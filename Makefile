.PHONY:
init:
	pip install tox pre-commit
	pre-commit install

.PHONY:
html: pop.csv
	tox run -e html
	cp pop.csv _build/html

.PHONY:
lint:
	tox run -e lint,linkcheck

.PHONY:
add-author:
	tox run -e add-author

.PHONY:
sync-authors:
	tox run -e sync-authors

.PHONY:
clean:
	rm -rf _build
	rm -rf .technote
	rm -rf .tox

.FORCE:

pop.csv: .FORCE
	pip install -r operations_milestones/requirements.txt
	( \
                . operations_milestones/venv/bin/activate; \
                python operations_milestones/opsMiles.py --pop -q "and filter=11380"  -u ${JIRA_USER} -p ${JIRA_PASSWORD} \
        )
	echo `date` >> index.rst
	echo `date` >> pop.csv

