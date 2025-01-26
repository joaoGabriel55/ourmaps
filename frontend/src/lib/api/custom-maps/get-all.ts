import type { CustomMap } from "$core/custom-map";
import { type HTTPClient } from "$lib/api/http-client";
import { toCustomMap } from "./parser";

export const getAllCustomMaps = async (
  ownerId: string,
  httpClient: HTTPClient
): Promise<CustomMap[]> => {
  try {
    const { data } = await httpClient.get(`/custom_maps?owner_id=${ownerId}`);

    return data?.map(toCustomMap);
  } catch (error: any) {
    throw error;
  }
};
