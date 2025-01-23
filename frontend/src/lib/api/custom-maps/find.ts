import type { CustomMap } from "$core/custom-map";
import { ourMapsAPI } from "$lib/api/http-client";

export const findCustomMap = async (id: string): Promise<CustomMap | null> => {
  try {
    const { data } = await ourMapsAPI.get(`/custom_maps/${id}`);

    return {
      id: data.id,
      name: data.name,
      ownerId: data.owner_id,
      description: data.description,
      center: data.center,
      visibility: data.visibility,
      content: data.content,
      createdAt: data.created_at,
      updatedAt: data.updated_at,
    };
  } catch (error: any) {
    if ("status" in error && error.status === 404) {
      return null;
    }

    throw error;
  }
};
