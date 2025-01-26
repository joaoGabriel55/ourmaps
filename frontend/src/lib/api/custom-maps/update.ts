import type { CustomMap } from "$core/custom-map";
import { type HTTPClient } from "$lib/api/http-client";

export type UpdateCustomMapInput = Omit<
  CustomMap,
  "createdAt" | "updatedAt" | "owner"
> & {
  ownerId: string;
};

export const updateCustomMap = async (
  map: UpdateCustomMapInput,
  httpClient: HTTPClient
) => {
  return await httpClient.put(`/custom_maps/${map.id}`, {
    id: map.id,
    name: map.name,
    owner_id: map.ownerId,
    center: map.center,
    description: map.description,
    content: map.content,
    visibility: map.visibility,
  });
};
