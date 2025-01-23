import type { CustomMap } from "$core/custom-map";
import { ourMapsAPI } from "$lib/api/http-client";
import { toCustomMap } from "./parser";

export const findCustomMap = async (id: string): Promise<CustomMap | null> => {
  try {
    const { data } = await ourMapsAPI.get(`/custom_maps/${id}`);

    return toCustomMap(data);
  } catch (error: any) {
    if ("status" in error && error.status === 404) {
      return null;
    }

    throw error;
  }
};
