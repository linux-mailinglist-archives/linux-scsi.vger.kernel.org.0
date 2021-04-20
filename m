Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFEC36530D
	for <lists+linux-scsi@lfdr.de>; Tue, 20 Apr 2021 09:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbhDTHS4 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 20 Apr 2021 03:18:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:55306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229731AbhDTHSw (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 20 Apr 2021 03:18:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0F34E61154;
        Tue, 20 Apr 2021 07:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618903100;
        bh=lGnIOSzz+/Tjw1GF9ijhnq+D7vLmF70UBSYAWWr7KBk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KWxZ24FVI3gyv5P4ai5efO0VZxEuTziQhwoXJsiYtXRXbLrhydWztgKVG2dz9j/K2
         tM6xKW6/bIGx7rDSFdsFhN811HMGl7T7LlfJQkCsBtRDOZl5pb4grkSGFqTIVbL8JJ
         uEnqCFxKmAd/2nypZ79/7/yCTLGGFQMjGnuynHEg=
Date:   Tue, 20 Apr 2021 09:18:18 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     Subbu Seetharaman <subbu.seetharaman@broadcom.com>,
        Ketan Mukadam <ketan.mukadam@broadcom.com>,
        Jitendra Bhivare <jitendra.bhivare@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: be2iscsi: Reset the address passed in
 beiscsi_iface_create_default
Message-ID: <YH6AOlbWdyCdVKvq@kroah.com>
References: <20210407002445.2209330-1-pakki001@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407002445.2209330-1-pakki001@umn.edu>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, Apr 06, 2021 at 07:24:45PM -0500, Aditya Pakki wrote:
> if_info is a local variable that is passed to beiscsi_if_get_info. In
> case of failure, the variable is free'd but not reset to NULL. The patch
> avoids security issue by passing NULL to if_info.

That is just not true at all.

Stop submitting patches that you know are invalid.  Your experiment is
not ethical, and not welcome or appreciated.

greg k-h
