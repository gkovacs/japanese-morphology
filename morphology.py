import sys
reload(sys)
sys.setdefaultencoding('utf-8')
import codecs

from fsa import FSA
import yaml
from featurelite import unify

def startswith(stra, strb):
    return stra[:len(strb)] == strb

def endswith(stra, strb):
    return strb == '' or stra[-len(strb):] == strb

class YAMLwrapper(object):
    def __init__(self, yamlstr):
        self.yamlstr = yamlstr
        self._cache = None
    def value(self):
        if self._cache is not None: return self._cache
        self._cache = yaml.load(self.yamlstr)
        return self._cache

def combine_features(a, b):
    """
    Return an object that combines the feature labels a and b.
    
    If a and b are strings, they are combined by concatenation (as in
    the original PC-KIMMO). If they are feature dictionaries, then they
    are unified in a way that always succeeds: the newer dictionary, b,
    wins all conflicts.
    """
    def override_features(a, b):
        return b

    if isinstance(a, YAMLwrapper): a = a.value()
    if isinstance(b, YAMLwrapper): b = b.value()
    if isinstance(a, str) and isinstance(b, str):
        return a+b
    else:
        d = {}
        vars = {}

        return unify(a, b, vars, fail=override_features)
    return '%s%s' % (a, b)

class KimmoMorphology(object):
    def __init__(self, fsa):
        self._fsa = fsa
    def fsa(self): return self._fsa
    def valid_lexical(self, state, word, alphabet):
        trans = self.fsa()._transitions[state]
        for label in trans.keys():
            if label is not None and label[0].startswith(word) and len(label[0]) > len(word):
                next = label[0][len(word):]
                for pair in alphabet:
                    if next.startswith(pair.input()): yield pair.input()
    def next_states(self, state, word):
        choices = self.fsa()._transitions[state]
        for (key, value) in choices.items():
            if key is None:
                if word == '':
                    for next in value: yield (next, None)
            else:
                if key[0] == word:
                    for next in value:
                        yield (next, key[1])
                    
    @staticmethod
    def load(filename):
        f = codecs.open(filename, encoding="utf-8")
        result = KimmoMorphology.from_text(f.read())
        f.close()
        return result
    @staticmethod
    def from_text(text):
        fsa = FSA([], {}, 'Begin', ['End'])
        state = 'Begin'
        for line in text.split('\n'):
            line = line.strip()
            if not line or line.startswith(';'): continue
            if line[-1] == ':':
                state = line[:-1]
            else:
                if line.split()[0].endswith(':'):
                    parts = line.split()
                    name = parts[0][:-1]
                    next_states = parts[1:]
                    for next in next_states:
                        fsa.insert_safe(name, None, next)
                elif len(line.split()) > 2:
                    # this is a lexicon entry
                    word, next, features = line.split(None, 2)
                    if word.startswith('"') or\
                    word.startswith("'") and word.endswith("'"):
                        word = eval(word)
                    if features:
                        if features == 'None': features = None
                        elif features[0] in '\'"{':
                            features = YAMLwrapper(features)
                    fsa.insert_safe(state, (word, features), next)
                elif len(line.split()) == 2:
                    word, next = line.split()
                    features = ''
                    if word == "''":
                        word = ''
                    fsa.insert_safe(state, (word, features), next)
                else:
                    print "Ignoring line in morphology: %r" % line
        return KimmoMorphology(fsa)

def demo():
    print KimmoMorphology.load('english.lex')

if __name__ == '__main__':
    demo()
