import type { CustomMap } from "$core/custom-map";
import { ourMapsAPI } from "$lib/api/http-client";
import { toCustomMap } from "./parser";

export const getAllCustomMaps = async (
  ownerId: string
): Promise<CustomMap[]> => {
  try {
    const { data } = await ourMapsAPI.get(`/custom_maps?owner_id=${ownerId}`);

    return data?.map(toCustomMap);
  } catch (error: any) {
    throw error;
  }
};
