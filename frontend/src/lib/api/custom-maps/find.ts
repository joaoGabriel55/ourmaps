import type { CustomMap } from "$core/custom-map";
import { ourMapsAPI } from "$lib/api/http-client";

export const findCustomMap = async (id: string): Promise<CustomMap> => {
  const response = await ourMapsAPI.get(`/custom_maps/${id}`);

  return {
    id: response.id,
    name: response.name,
    ownerId: response.owner_id,
    description: response.description,
    center: response.center,
    visibility: response.visibility,
    content: response.content,
    createdAt: response.created_at,
    updatedAt: response.updated_at,
  };
};
