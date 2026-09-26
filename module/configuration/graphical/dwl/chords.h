#ifndef DWL_CHORDS_H
#define DWL_CHORDS_H

#include <stddef.h>
#include <stdint.h>

#define CHORD_MAX_KEYS 4

typedef struct {
	uint32_t mod;
	xkb_keysym_t keys[CHORD_MAX_KEYS];
	size_t length;
	void (*func)(const Arg *);
	const Arg arg;
} Chord;

typedef enum {
	ChordNone,
	ChordPrefix,
	ChordComplete
} ChordMatch;

static ChordMatch
matchchord(const Chord *bindings, size_t count, uint32_t mods, uint32_t ignored_mods,
		const xkb_keysym_t *keys, size_t length, const Chord **complete)
{
	ChordMatch result = ChordNone;
	size_t i, j;

	*complete = NULL;
	if (!length || length > CHORD_MAX_KEYS)
		return ChordNone;

	for (i = 0; i < count; i++) {
		const Chord *binding = &bindings[i];

		if (binding->length < length || binding->length > CHORD_MAX_KEYS ||
				(mods & ~ignored_mods) != (binding->mod & ~ignored_mods))
			continue;
		for (j = 0; j < length && keys[j] == binding->keys[j]; j++);
		if (j != length)
			continue;
		if (binding->length == length) {
			*complete = binding;
			return ChordComplete;
		}
		result = ChordPrefix;
	}
	return result;
}

#endif
