# php bin/console
console() {
    php bin/console "$@"
}

# Reload database
db() {
    php bin/console doctrine:database:drop --force
    php bin/console doctrine:database:create
    php bin/console doctrine:migrations:migrate -n
    php bin/console doctrine:fixtures:load -n
}

# Reload whole project
reload() {
    composer install
    db
    yarn build
}

# Cache clear
cacl() {
    php bin/console cache:clear
}

# PHP Stan quality check
phpstan() {
    vendor/bin/phpstan analyse
}

# PHP CS Fixer quality check
csfixer() {
    vendor/bin/php-cs-fixer fix --diff --allow-risky=yes
}

# Global quality check
quality() {
    php bin/console lint:twig templates
    php bin/console doctrine:schema:validate
    vendor/bin/php-cs-fixer fix --diff --allow-risky=yes
    vendor/bin/phpstan analyse -c phpstan.dist.neon src
}
