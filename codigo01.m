% Generar un conjunto de datos de ejemplo
rng(0); % Para reproducibilidad
num_samples = 300;
num_clusters = 4;
cluster_std = 0.60;

% Generar datos aleatorios usando la función 'mvnrnd'
mu = [1 1; 5 5; 9 1; 3 7]; % Centros de los clusters
sigma = cat(3, cluster_std * eye(2), cluster_std * eye(2), cluster_std * eye(2), cluster_std * eye(2));
X = [];
for i = 1:num_clusters
    X = [X; mvnrnd(mu(i, :), sigma(:, :, i), num_samples / num_clusters)];
end

% Aplicar K-means con k=4
[idx, centroids] = kmeans(X, num_clusters);

% Visualizar los datos y los centroides
figure;
gscatter(X(:, 1), X(:, 2), idx, 'bgmr', 'o', 8);
hold on;
plot(centroids(:, 1), centroids(:, 2), 'kx', 'MarkerSize', 15, 'LineWidth', 3);
title('K-means Clustering Example');
xlabel('Feature 1');
ylabel('Feature 2');
legend('Cluster 1', 'Cluster 2', 'Cluster 3', 'Cluster 4', 'Centroids', 'Location', 'Best');
hold off;
