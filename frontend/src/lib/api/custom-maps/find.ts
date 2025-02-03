import type { CustomMap } from "$core/custom-map";
import { type HTTPClient } from "$lib/api/http-client";
import { errorHandler } from "../helpers/errors";
import { toCustomMap } from "./parser";

export const findCustomMap = async (
  id: string,
  httpClient: HTTPClient
): Promise<{ data?: CustomMap; status: number }> => {
  try {
    const response = await httpClient.get(`/custom_maps/${id}`);

    return { ...response, data: toCustomMap(response.data) };
  } catch (error: any) {
    return errorHandler(error);
  }
};
