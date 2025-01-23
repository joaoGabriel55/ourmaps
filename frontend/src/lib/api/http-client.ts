import axios from "axios";

import { env } from "$env/dynamic/public";

const makeHttpClient = (baseUrl: string) => {
  const axiosInstance = axios.create({
    baseURL: baseUrl,
  });

  return {
    get: async (url: string) => {
      const response = await axiosInstance.get(url);

      return { data: response.data, status: response.status };
    },
    post: async (url: string, data: any) => {
      const response = await axiosInstance.post(url, data);

      return { data: response.data, status: response.status };
    },
    put: async (url: string, data: any) => {
      const response = await axiosInstance.put(url, data);

      return { data: response.data, status: response.status };
    },
  };
};

export const ourMapsAPI = makeHttpClient(env.PUBLIC_API_URL);
