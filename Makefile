build: website.el
	@echo "Building the website"
	emacs --batch -q -l website.el -f org-publish-all


clean:
	@echo "Cleaning up.."
	@rm -rvf *.elc
	@rm -rvf public
	@rm -rvf ~/.org-timestamps/*


pub:
	$(MAKE) clean
	git worktree prune
	rm -rf .git/worktrees/public

	@echo "Checking out gh-pages branch into public"
	git worktree add -B gh-pages public origin/gh-pages

	@echo "Removing existing files"
	rm -rf public/*

	$(MAKE) build

	@echo "Updating gh-pages branch"
	cd public && git add --all && git commit -m "publishing to gh-pages" && git push origin gh-pages --force
