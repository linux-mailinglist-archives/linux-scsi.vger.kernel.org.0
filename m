Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14E5B36515
	for <lists+linux-scsi@lfdr.de>; Wed,  5 Jun 2019 22:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfFEUGO (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 5 Jun 2019 16:06:14 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38371 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbfFEUGN (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 5 Jun 2019 16:06:13 -0400
Received: by mail-pg1-f195.google.com with SMTP id v11so12995592pgl.5
        for <linux-scsi@vger.kernel.org>; Wed, 05 Jun 2019 13:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l7GhV0rxoysHd+vvOUHogmhN5DQrglKoRNofE0ycuO0=;
        b=hN6b0WC20PQgBwgB8GcxiUQNjzpKmlnWeqPxJINYTrzJ4bm3njIQPSZqbc7xR2m6VI
         KyvvUi/dSLNVG6oDyBXgeBHzfbYJr5SngfFoJQ4HClmJrcss92fT70J7krjz/+Cb2/l1
         FxMUmok4aYP/FH1i9+23AYbGtjLZpnEcOV6+6p6IbCQOMJXuS/VQ6YtoWnNvpChf9BLZ
         ovISLwjgeQXk1cmKf/dwf5EzFicUHMPPqwUrlnLRDomCi41jfvOkz1IniPjlqqrBSfLW
         bRCBpL9ZDH8ypaDStAvFsbHQllTErDRxWDw/VLP2dcPRcHk0XMCHTJocyYpMzqaKUe9R
         zuOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l7GhV0rxoysHd+vvOUHogmhN5DQrglKoRNofE0ycuO0=;
        b=BDWu9uaRp8nD9oUp9Sy8nm1loeqSvqMj+S3UQ5qcJFZDKSRVTwyctDla6JWXOTQRks
         bdJuXP2XtHJ7Vs3I/40EotPLib5WC224DxH0kHsbmBMS58jZNYZvrSv3mCNvc4HSWnNx
         yoR1sFZ/+UiQ2L8eDX5LjF3pI1Ys8+gpYJoBBnAbXqEQc24wWq85ahVlE/ymnRszcPrr
         CZ3WP9W32K5DFhRni7A8kvjgLq8/xNKeRWaWSNWNkzqsKhR1uwcJF6AL/K4JypgDQJIC
         R1QoqQSYqkuNHIW5xbHFOd+mAFSvBMK7/s7Xs8NJoqqDehxLF1obzP5ALoT2931+nTh8
         QgtQ==
X-Gm-Message-State: APjAAAUTm0yB+sZVVf1qZL2BrIBoh6i9ROL5cXlYDHAjuxEh/Qd62kXl
        TIlZ/Mx0+wM+csnKM4mjsCj39A==
X-Google-Smtp-Source: APXvYqx/+/Zs8iF6UF8Q8m4EDjG/ZA+q/uo9tVjjqADp8znFIDFnHuncS1pney7X90oCg9wYY8pwyA==
X-Received: by 2002:a17:90a:2648:: with SMTP id l66mr18261604pje.65.1559765172900;
        Wed, 05 Jun 2019 13:06:12 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id x5sm28978961pjp.21.2019.06.05.13.06.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 05 Jun 2019 13:06:12 -0700 (PDT)
Date:   Wed, 5 Jun 2019 13:06:10 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-scsi@vger.kernel.org, linux-hyperv@vger.kernel.org,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: Re: [PATCH] revert async probing of VMBus scsi device
Message-ID: <20190605130610.4c9ca561@hermes.lan>
In-Reply-To: <20190605192647.GA25034@infradead.org>
References: <20190605185205.12583-1-sthemmin@microsoft.com>
        <20190605185637.GA31439@infradead.org>
        <20190605120640.00358689@hermes.lan>
        <20190605190722.GA19684@infradead.org>
        <20190605121020.1a41b753@hermes.lan>
        <20190605192647.GA25034@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, 5 Jun 2019 12:26:47 -0700
Christoph Hellwig <hch@infradead.org> wrote:

> On Wed, Jun 05, 2019 at 12:10:20PM -0700, Stephen Hemminger wrote:
> > > Sure.  But they should not get a way out for just one specific driver.  
> > 
> > There are people running new kernels on 6 year old distributions.
> > Was every distribution smart enough then? If you think so, then
> > this not necessary.  
> 
> I think you are missing my point.  If we want a way to disable this,
> we:
> 
>  a) want it opt-in
>  b) it needs to for the whole SCSI layer and not just one driver

There is some possible issues with how initial images are deployed
with temporary disks.  The temp disks come pre-formatted with a blank
NTFS and cloudinit reformats them to ext4 the first time.

Not sure if ordering matters, or if cloudinit is smart enough to do
the right thing. I am trying to get an answer.

It might just be that the first boot should turn off async probing
for the whole scsi layer via kernel cmdline. Or it might not be an issue
if cloudinit was written by developers smart enough to handle moving
disks.
