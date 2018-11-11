import 'package:flutter/material.dart';

class HomeSearchDelegate extends SearchDelegate<String> {
  final List<String> _data = new List<String>.generate(100001, (int i) => i.toString()).reversed.toList();
  final List<String> _history = <String>['NBA', 'MLB', 'NFL', 'WWE'];

  @override
  Widget buildLeading(BuildContext context) {
    return new IconButton(
      tooltip: 'Back',
      icon: new AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    final Iterable<String> suggestions = query.isEmpty
        ? _history
        : _data.where((String i) => '$i'.startsWith(query));

    return new _SuggestionList(
      query: query,
      suggestions: suggestions.map((String i) => '$i').toList(),
      onSelected: (String suggestion) {
        query = suggestion;
        showResults(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final String searched = query;
    if (searched == null || !_data.contains(searched)) {
      return new Center(
        child: new Text(
          'Can not find the result that matches "$query".',
          textAlign: TextAlign.center,
        ),
      );
    }

    return new ListView(
      children: <Widget>[
        new _ResultCard(
          title: 'This integer',
          integer: searched,
          searchDelegate: this,
        ),
        new _ResultCard(
          title: 'Next integer',
          integer: searched,
          searchDelegate: this,
        ),
        new _ResultCard(
          title: 'Previous integer',
          integer: searched,
          searchDelegate: this,
        ),
      ],
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      query.isEmpty
          ? new IconButton(
        tooltip: 'Voice Search',
        icon: const Icon(Icons.mic),
        onPressed: () {
//          query = 'TODO: implement voice input';
        },
      )
          : new IconButton(
        tooltip: 'Clear',
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      )
    ];
  }
}

class _ResultCard extends StatelessWidget {
  const _ResultCard({this.integer, this.title, this.searchDelegate});

  final String integer;
  final String title;
  final SearchDelegate<String> searchDelegate;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return new GestureDetector(
      onTap: () {
        searchDelegate.close(context, integer);
      },
      child: new Card(
        child: new Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Column(
            children: <Widget>[
              new Text(title),
              new Text(
                '$integer',
                style: theme.textTheme.headline.copyWith(fontSize: 72.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SuggestionList extends StatelessWidget {
  const _SuggestionList({this.suggestions, this.query, this.onSelected});

  final List<String> suggestions;
  final String query;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return new ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (BuildContext context, int i) {
        final String suggestion = suggestions[i];
        return new ListTile(
          leading: query.isEmpty ? const Icon(Icons.history) : const Icon(null),
          title: new RichText(
            text: new TextSpan(
              text: suggestion.substring(0, query.length),
              style: theme.textTheme.subhead.copyWith(fontWeight: FontWeight.bold),
              children: <TextSpan>[
                new TextSpan(
                  text: suggestion.substring(query.length),
                  style: theme.textTheme.subhead,
                ),
              ],
            ),
          ),
          onTap: () {
            onSelected(suggestion);
          },
        );
      },
    );
  }
}