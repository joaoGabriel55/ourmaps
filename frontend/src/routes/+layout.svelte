<script>
  import Header from "$lib/components/Header.svelte";
  import MapsList from "$lib/components/MapsList.svelte";
  import "../app.css";

  let { data, children } = $props();

  let userMaps = data.userMaps;
  let sharedMaps = data.sharedMaps;
  let closeSidebar = data.closeSideBar;
</script>

{#if !closeSidebar}
  <div class="grid grid-cols-[1fr_3fr] h-screen">
    <aside class="bg-white">
      <Header />
      <section class="m-4">
        <a data-sveltekit-reload class="btn btn-primary w-full" href="/new">Create new map</a>
      </section>
      <MapsList title="My Maps" maps={userMaps} />
      <hr class="my-4" />
      <MapsList title="Shared Maps" maps={sharedMaps} />
    </aside>
    {@render children()}
  </div>
{/if}

<div class="w-screen h-screen">
  {#if closeSidebar}
    {@render children()}
  {/if}
</div>

<style lang="postcss">
  :global(html) {
    background-color: theme(colors.gray.100);
  }
</style>
