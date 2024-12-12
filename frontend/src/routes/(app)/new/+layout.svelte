<script>
  let { children } = $props();
</script>

{@render children()}

<style lang="postcss">
  :global(html) {
    background-color: theme(colors.gray.100);
  }
</style>
