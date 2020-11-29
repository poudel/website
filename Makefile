build: website.el
	@echo "Building the website"
	emacs --batch -q -l website.el -f org-publish-all
	cp src/CNAME public/


#needs inotify-tools installed
watch:
	bash -c "while inotifywait -r -e close_write ./src; do make build; done"


serve:
	$(MAKE) build
	python -m http.server --directory=public 2929

clean:
	@echo "Cleaning up.."
	@rm -rvf *.elc
	@rm -rvf public
	@rm -rvf ~/.org-timestamps/*


# Nicked from https://gohugo.io/hosting-and-deployment/hosting-on-github/#deployment-of-project-pages-from-your-gh-pages-branch
pub:
	bash -c "if [ \"`git status -s`\" ]; then echo \"Working directory is dirty\"; exit 1; fi;"
	$(MAKE) clean
	git worktree prune
	rm -rf .git/worktrees/public

	@echo "Checking out gh-pages branch into public"
	git worktree add -B gh-pages public origin/gh-pages

	@echo "Removing existing files"
	rm -rf public/*

	$(MAKE) build

	@echo "Updating gh-pages branch"
	cd public && git add . && git commit -m "publishing to gh-pages" && git push origin gh-pages --force
