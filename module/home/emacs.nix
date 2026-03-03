{pkgs, ...}:
{
  programs.emacs = {
    enable = true;
		package = (pkgs.emacsPackagesFor pkgs.emacs).emacsWithPackages (epkgs: with epkgs; [
			use-package
			magit
			vterm
			evil
			evil-collection
			general
			all-the-icons
			all-the-icons-dired
			nerd-icons
			company
			company-box
			dashboard
			diminish
			neotree
			counsel
			ivy
			all-the-icons-ivy-rich
			ivy-rich
			toc-org
			org-bullets
			projectile
			lsp-mode
			lsp-ui
			flycheck
			haskell-mode
			lsp-haskell
			lsp-pyright
			rust-mode
			rustic
			cargo
      flycheck-rust
			toml-mode
			git-timemachine
			transient
			vterm-toggle
			rainbow-delimiters
			rainbow-mode
			doom-themes
			which-key
			nix-mode
			nixfmt
      yasnippet
      yasnippet-snippets
      pdf-tools
      company-auctex
      auctex
      evil-mc
    ]); 
	};

  home.file = {
    ".config/emacs/init.el".source = ./init.el;
    ".config/emacs/early-init.el".source = ./early-init.el;
    ".config/emacs/config.org".source = ./config.org;
  };
}
