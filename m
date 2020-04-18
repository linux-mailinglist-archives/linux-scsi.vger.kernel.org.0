Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3981AF3C6
	for <lists+linux-scsi@lfdr.de>; Sat, 18 Apr 2020 20:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbgDRSud (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 18 Apr 2020 14:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725824AbgDRSud (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Sat, 18 Apr 2020 14:50:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6671BC061A0C;
        Sat, 18 Apr 2020 11:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M2qa3/vc2/myvbMk+MYALeJsSLdNzC1fZAyoJyG68gE=; b=musbWlm7i2hjImd1CYGB5QW7l8
        Wn/kGpq4MEnK3EQO7eZeKDFT8eS5LR23e3CnYhCDStAgjQAFY5YBGVt6kelglv19B681ienPPYSaq
        YfDJC+H0H5NLdOmuRZEmcigYq143fNpyKGLW6QQRzawQ8loN2w3Tr8KqH0mfYRp8Pfor829wVUHqA
        l1trL/tl9vJG07nJcZqpDQmkbddJurRYVp9wZ2ld/OgdRFRqUkk7SeljH7WfG/EzD5GnLgRWzeBn2
        +F+hn6JAaMQT4MLsGR2BZlvqMq0c/4rnwpzB0mmIRStMWYlkSjUiT2M0RY1BWI/jkco5Jw22oyFTf
        oqBggJew==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jPsXx-0005fx-6n; Sat, 18 Apr 2020 18:50:33 +0000
Date:   Sat, 18 Apr 2020 11:50:33 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, linux-nvdimm@lists.01.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        Zzy Wysm <zzy@zzywysm.com>
Subject: Re: [PATCH 7/9] drivers/base: fix empty-body warnings in
 devcoredump.c
Message-ID: <20200418185033.GQ5820@bombadil.infradead.org>
References: <20200418184111.13401-1-rdunlap@infradead.org>
 <20200418184111.13401-8-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200418184111.13401-8-rdunlap@infradead.org>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Sat, Apr 18, 2020 at 11:41:09AM -0700, Randy Dunlap wrote:
> @@ -294,11 +295,11 @@ void dev_coredumpm(struct device *dev, s
>  
>  	if (sysfs_create_link(&devcd->devcd_dev.kobj, &dev->kobj,
>  			      "failing_device"))
> -		/* nothing - symlink will be missing */;
> +		do_empty(); /* nothing - symlink will be missing */
>  
>  	if (sysfs_create_link(&dev->kobj, &devcd->devcd_dev.kobj,
>  			      "devcoredump"))
> -		/* nothing - symlink will be missing */;
> +		do_empty(); /* nothing - symlink will be missing */
>  
>  	INIT_DELAYED_WORK(&devcd->del_wk, devcd_del);
>  	schedule_delayed_work(&devcd->del_wk, DEVCD_TIMEOUT);

Could just remove the 'if's?

+	sysfs_create_link(&devcd->devcd_dev.kobj, &dev->kobj,
+			"failing_device");
