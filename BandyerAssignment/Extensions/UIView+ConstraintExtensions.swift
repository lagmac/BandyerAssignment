//
//  UIButton+ConstraintExtensions.swift
//  BandyerAssignment
//
//  Created by Gino Preti on 26/03/21.
//

import UIKit

enum Position
{
    case CenterX
    case CenterY
    case Leading
    case Trailing
    case Top
    case Bottom
}

extension UIView
{
    func setConstraint(withWidth width: CGFloat,
                       height: CGFloat,
                       offsetX: CGFloat,
                       offSetY: CGFloat,
                       anchorX Xanchor: Position,
                       anchorY Yanchor: Position,
                       relativeToView view: UIView,
                       relativeToViewAnchorX xParentAnchor: Position,
                       relativeToViewAnchorY yParentAnchor: Position,
                       ignoreSafeArea: Bool = false,
                       isCentered: Bool = false)
    {        
        let widthConstrait = self.widthAnchor.constraint(equalToConstant: isCentered ?  width - (offsetX * 2) : width)
        let heightConstraint = self.heightAnchor.constraint(equalToConstant: isCentered ? height - (offSetY * 2) : height)
        
        let horizontalAnchor: NSLayoutXAxisAnchor = getNSLayoutXAxisAnchor(fromParent: view, anchor: xParentAnchor)
        let verticalAnchor: NSLayoutYAxisAnchor = getNSLayoutYAxisAnchor(fromParent: view, anchor: yParentAnchor)
        let horizontalConstraint: NSLayoutConstraint = getNSLayoutHorizontalConstraint(anchor: Xanchor, offsetX: isCentered ? 0 : offsetX, parentAnchor: horizontalAnchor)
        let verticalConstraint: NSLayoutConstraint = getNSLayoutHVerticalConstraint(anchor: Yanchor, offsetY: isCentered ? 0 : offSetY, parentAnchor: verticalAnchor)

        self.translatesAutoresizingMaskIntoConstraints = false;

        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstrait, heightConstraint])
    }
    
    private func getNSLayoutXAxisAnchor(fromParent parent: UIView, anchor: Position) -> NSLayoutXAxisAnchor
    {
        if (anchor == .Leading)
        {
            return parent.safeAreaLayoutGuide.leadingAnchor
        }
        else if (anchor == .Trailing)
        {
            return parent.safeAreaLayoutGuide.trailingAnchor
        }
        else if (anchor == .CenterX)
        {
            return parent.safeAreaLayoutGuide.centerXAnchor
        }
        
        return parent.safeAreaLayoutGuide.centerXAnchor
    }
    
    private func getNSLayoutYAxisAnchor(fromParent parent: UIView, anchor: Position) -> NSLayoutYAxisAnchor
    {
        if (anchor == .Bottom)
        {
            return parent.safeAreaLayoutGuide.bottomAnchor
        }
        else if (anchor == .Top)
        {
            return parent.safeAreaLayoutGuide.topAnchor
        }
        else if (anchor == .CenterY)
        {
            return parent.safeAreaLayoutGuide.centerYAnchor
        }
        
        return parent.safeAreaLayoutGuide.centerYAnchor
    }
    
    private func getNSLayoutHorizontalConstraint(anchor: Position, offsetX : CGFloat, parentAnchor: NSLayoutXAxisAnchor) -> NSLayoutConstraint
    {
        if (anchor == .Leading)
        {
            return self.leadingAnchor.constraint(equalTo: parentAnchor, constant: offsetX)
        }
        else if (anchor == .Trailing)
        {
            return self.trailingAnchor.constraint(equalTo: parentAnchor, constant: offsetX)
        }
        else if (anchor == .CenterX)
        {
            return self.centerXAnchor.constraint(equalTo: parentAnchor, constant: offsetX)
        }
        
        return self.centerXAnchor.constraint(equalTo: parentAnchor, constant: offsetX)
    }
    
    private func getNSLayoutHVerticalConstraint(anchor: Position, offsetY : CGFloat, parentAnchor: NSLayoutYAxisAnchor) -> NSLayoutConstraint
    {
        if (anchor == .Bottom)
        {
            return self.bottomAnchor.constraint(equalTo: parentAnchor, constant: offsetY)
        }
        else if (anchor == .Top)
        {
            return self.topAnchor.constraint(equalTo: parentAnchor, constant: offsetY)
        }
        else if (anchor == .CenterY)
        {
            return self.centerYAnchor.constraint(equalTo: parentAnchor, constant: offsetY)
        }
        
        return self.centerYAnchor.constraint(equalTo: parentAnchor, constant: offsetY)
    }
}
