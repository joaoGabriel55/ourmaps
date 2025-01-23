import { ourMapsAPI } from "$lib/api/http-client";
import type { CustomMap } from "$core/custom-map";

export type CreateCustomMapInput = Omit<
  CustomMap,
  "id" | "createdAt" | "updatedAt"
>;

export const createCustomMap = async (map: CreateCustomMapInput) => {
  const { data } = await ourMapsAPI.post("/custom_maps", {
    name: map.name,
    owner_id: map.ownerId,
    center: map.center,
    description: map.description,
    content: map.content,
    visibility: map.visibility,
  });

  return data;
};
