<script lang="ts">
  import { goto } from "$app/navigation";
  import type { User } from "$core/user";
  import { LogOut } from "lucide-svelte";

  let { user }: { user: User } = $props();

  const logout = () => goto("/logout");
</script>

<header class="p-4 bg-gray-200">
  <div class="max-w-4xl mx-auto flex gap-4 justify-between">
    <h1 class="text-2xl font-bold">OurMaps</h1>
    <div class="flex gap-4 items-center">
      <span>{user.name}</span>
      <div class="avatar placeholder">
        <div
          class="bg-green-500 w-8 h-8 p-4 rounded-2xl flex items-center justify-center"
        >
          <span class="text-semibold">{user.name[0]}</span>
        </div>
      </div>
      <button class="btn btn-ghost btn-circle" onclick={logout}>
        <LogOut />
      </button>
    </div>
  </div>
</header>
