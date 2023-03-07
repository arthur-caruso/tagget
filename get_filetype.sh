get_filetype () {
	ext='';
	case $(file -b $1) in
		*ASCII*) ext='.txt' ;;
		*JPEG*) ext='.jpg' ;;
		*PDF*) ext='.pdf' ;;
		*PNG*) ext='.png' ;;
		*GIF*) ext='.gif' ;;
		*WebM*) ext='.webm' ;;
		*Web/P*) ext='.webp' ;;
		# etc...
		*) ;;
	esac
}
