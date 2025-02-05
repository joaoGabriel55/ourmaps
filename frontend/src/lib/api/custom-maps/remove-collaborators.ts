import type { HTTPClient } from "../http-client";

export const removeCustomMapCollaborators = async (
  mapId: string,
  collaborators: Array<string>,
  httpClient: HTTPClient
) => {
  return await httpClient.delete(`/custom_maps/${mapId}/collaborators`, {
    collaborators,
  });
};
