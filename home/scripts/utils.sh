filter_choose() {
  FILTER_CHOOSE_OUTPUT=$(printf "%s\n" $1 | gum filter --placeholder "$2")
}

filter_choose_simple() {
  filter_choose $1 "Choose ..."
}

first_without_second() {
  FIRST_WITHOUT_SECOND_OUTPUT=$(comm -23 \ 
    <(sort <(printf "%s\n" $1)) \
    <(sort <(printf "%s\n" $2)))
}

gum_print() {
  gum style \
    --foreground 212 \
    --border-foreground 212 \
    --border double \
    --align center \
    --width 50 \
    "$1"
}
