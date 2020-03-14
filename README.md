# ADR Bootstrap

> Simple process for bootstraping command line tools for working with [Architecture Decision Records] (ADRs).

I have been a big fan of using ADRs for a long time and find myself installing [adr-tools] in all git repos that I end up spending any amount of time on. Being able to view the context of my decisions has been extremely useful in retrospect.

The goal of this repo is to speed up the process of adding them to a git repo along with some helpful tasks to assist with automation.

## Installation

### Prerequsites

The following dependencies are required;

- [make]
- [adr-tools]
- [graphviz]

This bootstrapping process will install a [makefile] which is the tool that will provide the automation.

```bash
curl -L -o Makefile https://raw.githubusercontent.com/shaunmclernon/adr-bootstrap/master/Makefile
```

That's it! It is ready to use.

## Usage

Running `make` by default will display the help text.

```bash
make
Architectural Decision Record (ADRs) task generator

Options:
 adr                            : Generate a new ADR readme index and graph.
 adr-new DECISON="new decision" : Generator a new decision record
 adr-graph (optional)           : Dynamically generic the visual graph of of the ADRs
 adr-readme (optional)          : Dynamically generate the ADR readme.
```

The first time, you call any of these commands, it will initialise the folder to store this decisions, currently; `doc/architecture/decisions`

It will also create the first decision record which is to use ADR

See 'doc/architecture/decisions/0001-record-architecture-decisions.md' for details.

### Generate ADR index and graph

```bash
make adr
```

View the generated `doc/architecture/decisions/README.md` to see the list of ADRs and the graph of these decisions.

### Adding a new decision

Recording a new decision is as simple as follows. Using this wrapper approach is purely a helper so that the dates are written in British format. You can still use the adr tools as normal should you wish.

```bash
make adr-new DECISON="make first decision"
```

[Architecture Decision Records]: http://thinkrelevance.com/blog/2011/11/15/documenting-architecture-decisions
[make]: https://www.gnu.org/software/make/
[adr-tools]: hhttps://github.com/npryce/adr-tools/blob/master/INSTALL.md
[graphviz]: https://www.graphviz.org/download/
[makefile]: https://en.wikipedia.org/wiki/Makefile
