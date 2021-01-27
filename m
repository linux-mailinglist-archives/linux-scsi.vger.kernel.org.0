Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5EA305F6F
	for <lists+linux-scsi@lfdr.de>; Wed, 27 Jan 2021 16:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235534AbhA0PV3 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 27 Jan 2021 10:21:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:60522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343808AbhA0PU7 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 27 Jan 2021 10:20:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3918520771;
        Wed, 27 Jan 2021 15:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611760818;
        bh=6H0w+JxfUtiVEDnsxo2cN6Xx7Yc2UsDpgDJrqfB89/g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ovRZwQD4d6ENzXJtjSQRTQuxUQTxBk/0TmjUzUTDCpu7rMROBkAXbrgnostmI02eU
         vnXPfmJAyeW3ml2oATZcpDF+VI41LQrt1krQ8EXzDE9u+ZLnNVmO/NnasPQNSGGWAk
         F3EIWYU0JNuIyPHeMeslNSimAK2x4jEtEolkFtNY=
Date:   Wed, 27 Jan 2021 16:20:15 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Avri Altman <avri.altman@wdc.com>
Cc:     "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        yongmyung lee <ymhungry.lee@samsung.com>,
        Daejun Park <daejun7.park@samsung.com>,
        alim.akhtar@samsung.com, asutoshd@codeaurora.org,
        Zang Leigang <zangleigang@hisilicon.com>,
        Avi Shchislowski <avi.shchislowski@wdc.com>,
        Bean Huo <beanhuo@micron.com>, cang@codeaurora.org,
        stanley.chu@mediatek.com
Subject: Re: [PATCH 2/8] scsi: ufshpb: Add host control mode support to
 rsp_upiu
Message-ID: <YBGEr4F8LhWpG81S@kroah.com>
References: <20210127151217.24760-1-avri.altman@wdc.com>
 <20210127151217.24760-3-avri.altman@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210127151217.24760-3-avri.altman@wdc.com>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, Jan 27, 2021 at 05:12:11PM +0200, Avri Altman wrote:
> There are some limitations to activations / inactivations in host
> control mode - Add those.

I can not understand this changelog text, please make it more
descriptive as I have no way to know how to review this patch :(

thanks,

greg k-h
