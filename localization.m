function [ Localized_I ,R_Center , R_Radius ] = localization()%I )
%LOCALIZATION Summary of this function goes here
%   Detailed explanation goes here
I=imread('aeval1.bmp','bmp');


figure( 'Name', 'preprocessed image');
imshow(I );
J=rgb2gray(I);
e = edge(J, 'canny');
figure( 'Name', 'edge image');
imshow(e);
[centers,radii]=imfindcircles(e,[10 40]);
R_Center=centers;
R_Radius=radii;
viscircles(centers,radii,'EdgeColor','b'); %the small circle
[centers,radii]=imfindcircles(e,[40 150]);
R_Center_big=centers;
R_Radius_big=radii;
viscircles(centers,radii,'EdgeColor','b'); %the big circle
% for i=1:size(e,1)
%     for j=1:size(e,2)
%         if((i-R_Center(2))^2+(j-R_Center(1))^2<= R_Radius^2)
%             e(i,j)=100;
%         elseif((i-R_Center_big(2))^2+(j-R_Center_big(1))^2>= R_Radius_big^2)
%             e(i,j)=100;
%         end
%     end
% end
% figure( 'Name', 'e image');
% imshow(e);
 
Localized_I = int8(zeros(2*floor(R_Radius_big)));
for i=floor(R_Center_big(2)-R_Radius_big):floor(R_Center_big(2)+R_Radius_big)
    for j=floor(R_Center_big(1)-R_Radius_big):floor(R_Center_big(1)+R_Radius_big)
        X = i-floor(R_Center_big(2)-R_Radius_big)+1;
        Y = j-floor(R_Center_big(1)-R_Radius_big)+1;
        if(((i-R_Center_big(2))^2+(j-R_Center_big(1))^2<= R_Radius_big^2) && ((i-R_Center(2))^2+(j-R_Center(1))^2> R_Radius^2))
            Localized_I(X,Y)=J(i,j);
        end
    end
end
figure( 'Name', 'Localized_I image');
imshow(Localized_I,[0 255]);

end