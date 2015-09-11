var gulp = require('gulp'),
	path = require('path'),
	postcss = require('gulp-postcss'),
	autoprefixer = require('autoprefixer'),
	folders = require('gulp-folders');

var site = '/site/';

gulp.task('css', folders(site, function(folder) {
	var processors = [
		autoprefixer({
			browsers: ['last 2 versions', '> 5%']
		})
	];

	return gulp.src(path.join(site, folder, 'assets', 'css', '*.css'))
		.pipe(postcss(processors))
		.pipe(gulp.dest(''))
}));

gulp.task('post-process', ['css'])
