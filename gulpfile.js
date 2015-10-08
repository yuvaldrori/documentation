var gulp = require('gulp'),
	path = require('path'),
	postcss = require('gulp-postcss'),
	autoprefixer = require('autoprefixer'),
	jsonlint = require('gulp-jsonlint'),
	print = require('gulp-print'),
	folders = require('gulp-folders');

var site = '/site/';

gulp.task('css', folders(site, function(folder) {
	var processors = [
		autoprefixer({
			browsers: ['last 2 versions', '> 5%']
		})
	];

	return gulp.src(path.join(site, folder, 'assets', 'css', '*.css'))
		.pipe(print())
		.pipe(postcss(processors))
		.pipe(gulp.dest(''))
}));

gulp.task('jsonlint', function() {
	gulp.src('./*.json')
		.pipe(print())
		.pipe(jsonlint())
		.pipe(jsonlint.failAfterError())
});

gulp.task('post-process', ['css'])
gulp.task('lint', ['jsonlint'])
