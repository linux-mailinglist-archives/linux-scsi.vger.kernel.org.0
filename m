Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5B4E2D56F
	for <lists+linux-scsi@lfdr.de>; Wed, 29 May 2019 08:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbfE2GXS (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 May 2019 02:23:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60070 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbfE2GXS (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 29 May 2019 02:23:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ko7R6sT1UehlRj0bJMyAyDrGSCFCxS6Q1zpbk2bJ/wE=; b=DcfuD/wN8e5mcz/Sn+EpWmYG5
        z9K66604+5wt+LouVxM2rv961k9WueEHjC5f4maVynNbDexm1szGZ8BGzBDvmk4XHoDBpJfshUKbQ
        UgggUKK4xeT7H6nJ3Th+dVyPBmPiUUvR14BDecfxJtsWxl3u7fYlWilSYA1Wi2MHmHmYZ7XlM0Aia
        CWHmqtJRJIJ9q50EBFIRpGsCNcflCM6AqCMmOHHhf+4keoBsc/X3qylbUycDnkslot57ubwLzv8vW
        4M2wRqfI7bUePoJ0EjZej+i+Ws8yNyeW/yMOMGw8R4sUzv06BZTMZ+YJqiP/a7Ry6Pdae1X/lgLzJ
        T5MTxm/Jw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hVrzY-0001DT-G9; Wed, 29 May 2019 06:23:16 +0000
Date:   Tue, 28 May 2019 23:23:16 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wd719x: pass GFP_ATOMIC instead of GFP_KERNEL
Message-ID: <20190529062316.GA3997@infradead.org>
References: <20190529013540.GA20273@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529013540.GA20273@hari-Inspiron-1545>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, May 29, 2019 at 07:05:40AM +0530, Hariprasad Kelam wrote:
> wd719x_chip_init is getting called in interrupt disabled
> mode(spin_lock_irqsave) , so we need to GFP_ATOMIC instead
> of GFP_KERNEL.
> 
> Issue identified by coccicheck

I don't think request_firmware is any more happy being called under
a spinlock.  The right fix is to not hold a spinlock over the board
initialization.
