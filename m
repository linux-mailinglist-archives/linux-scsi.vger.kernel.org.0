Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A96CD14C710
	for <lists+linux-scsi@lfdr.de>; Wed, 29 Jan 2020 08:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgA2Hw3 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 Jan 2020 02:52:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:48828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726068AbgA2Hw3 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 29 Jan 2020 02:52:29 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F142206A2;
        Wed, 29 Jan 2020 07:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580284349;
        bh=E2gB8/IVYfzCG8u8xgT7bImHIwd51ldFMW6eqcDAvb8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zpEMqlQPSjBfOuVeijexexAZ9NASLTff4lkKWYeLMj2eifuhCGX5PwFMaGR4y2CPN
         aNlRnZ8y5WAxFXJQmoS8HZhO5grNJvzsU56p4fNU+DUnOLNCh9A3WQD/SoO3wpnvp9
         VBG3y7lR3zfoDKkVTGQNRu7/EgeGh3GV1ySWfaZs=
Date:   Wed, 29 Jan 2020 08:52:25 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Stanley Chu <stanley.chu@mediatek.com>
Cc:     linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        avri.altman@wdc.com, alim.akhtar@samsung.com, jejb@linux.ibm.com,
        beanhuo@micron.com, asutoshd@codeaurora.org, cang@codeaurora.org,
        matthias.bgg@gmail.com, bvanassche@acm.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kuohong.wang@mediatek.com, peter.wang@mediatek.com,
        chun-hung.wu@mediatek.com, andy.teng@mediatek.com,
        stable@vger.kernel.org
Subject: Re: [PATCH v3 3/4] scsi: ufs: fix Auto-Hibern8 error detection
Message-ID: <20200129075225.GA3774452@kroah.com>
References: <20200129073902.5786-1-stanley.chu@mediatek.com>
 <20200129073902.5786-4-stanley.chu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200129073902.5786-4-stanley.chu@mediatek.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, Jan 29, 2020 at 03:39:01PM +0800, Stanley Chu wrote:
> Auto-Hibern8 may be disabled by some vendors or sysfs
> in runtime even if Auto-Hibern8 capability is supported
> by host. If Auto-Hibern8 capability is supported by host
> but not actually enabled, Auto-Hibern8 error shall not happen.
> 
> To fix this, provide a way to detect if Auto-Hibern8 is
> actually enabled first, and bypass Auto-Hibern8 disabling
> case in ufshcd_is_auto_hibern8_error().
> 
> Fixes: 8217444 ("scsi: ufs: Add error-handling of Auto-Hibernate")

This should be:
Fixes: 821744403913 ("scsi: ufs: Add error-handling of Auto-Hibernate")
