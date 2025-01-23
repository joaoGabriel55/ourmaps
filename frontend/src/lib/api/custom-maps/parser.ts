import type { CustomMap } from "$core/custom-map";

export const toCustomMap = (map: any): CustomMap => {
  return {
    id: map.id,
    name: map.name,
    owner: map.owner,
    description: map.description,
    center: map.center,
    visibility: map.visibility,
    content: map.content,
    createdAt: map.created_at,
    updatedAt: map.updated_at,
  };
};
