#ifndef DWL_WORKSPACES_H
#define DWL_WORKSPACES_H

#include <stdint.h>

static uint32_t
firstfreeworkspacetag(uint32_t used, uint32_t mask)
{
	uint32_t tag;

	for (tag = 1; tag && (tag & mask); tag <<= 1)
		if (!(used & tag))
			return tag;
	return 0;
}

static uint32_t
initialworkspacetag(uint32_t preferred, uint32_t used, uint32_t mask)
{
	if (preferred && ((preferred & (preferred - 1)) || (preferred & ~mask)))
		return 0;
	if (preferred && !(preferred & used))
		return preferred;
	return firstfreeworkspacetag(used, mask);
}

static void
switchworkspacetags(uint32_t current[2], unsigned int *current_selected,
		uint32_t other[2], unsigned int *other_selected, uint32_t target)
{
	uint32_t previous = current[*current_selected];

	*current_selected ^= 1;
	current[*current_selected] = target;
	if (other) {
		*other_selected ^= 1;
		other[*other_selected] = previous;
	}
}

#endif
