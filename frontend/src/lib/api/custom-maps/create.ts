import type { CustomMap } from "$core/custom-map";
import { type HTTPClient } from "$lib/api/http-client";

export type CreateCustomMapInput = Omit<
  CustomMap,
  "id" | "createdAt" | "updatedAt" | "owner"
> & {
  ownerId: string;
};

export const createCustomMap = async (
  map: CreateCustomMapInput,
  httpClient: HTTPClient
) => {
  const { data } = await httpClient.post("/custom_maps", {
    name: map.name,
    owner_id: map.ownerId,
    center: map.center,
    description: map.description,
    content: map.content,
    visibility: map.visibility,
  });

  return data;
};
