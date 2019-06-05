Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA5F936484
	for <lists+linux-scsi@lfdr.de>; Wed,  5 Jun 2019 21:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfFETRV (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 5 Jun 2019 15:17:21 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36013 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbfFETRU (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 5 Jun 2019 15:17:20 -0400
Received: by mail-pg1-f196.google.com with SMTP id a3so5535963pgb.3
        for <linux-scsi@vger.kernel.org>; Wed, 05 Jun 2019 12:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dhmtJ4+79vRolYDJuB/HeVo2S5DNUc8fMTsNT6fH0i0=;
        b=F8KuVE0d725JnKlMiv02aZ4rRXlJ9I/vn2LLG24+latMd3LSnG12/jfOXWJD2X/jbk
         8EdRhgr60Iuw8SjKl0AcQ13JsEHBrxj05xHTT75dj0l/Qu1fciOl/d+HNkuaCYIOEq13
         lBNXbfnPXZLCgLmFsP+8hO/H4KiCwGHx4gIx38xJEczDJiLNWrsm4gesIV6ahHpEzfhp
         mdILtmy3Y7HsrggqjBb76Igji2tadfBj7NYuEudnwLCAtianakhgRweW/ElIbbDCWhxN
         yNwCXa7Nx2JSf+Fefqd4KOAtFk5ThZt/ABiV5ORlNiCi2oyx1dsh3Gm0xthYrz8l5mFt
         6B3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dhmtJ4+79vRolYDJuB/HeVo2S5DNUc8fMTsNT6fH0i0=;
        b=tu+MUV4XU0yx+/UgRnKkbOm7Gv35LJAML5Gn9LrBq9aecH/jU28ihKSS879bXm/Vse
         +LrSmTJPNJX0dWvvGUU+2h5iun1vqG5hPxEXaoEw22p9Do0Tu/zCW7xgmO09U8WxKCg6
         CoXGCRJbDAV10+ZFoZnwd7NNHRZlhJVbJpyJTkmz3MMuqQ8n3+jultSspDie8tNwbY3t
         E/Q3eU62hvsd3f+0fZuJKRPJhRwI104ORjf2CABso+0u//Yn2rAeAt7EpJBYd0V6Y4XL
         Qz6mwP+zVaURS8uq49YzzH3OhgUw0AzrKgnqyEA8zTTDs74jqHIjhA3w17Mxo2fVN3TB
         pFtQ==
X-Gm-Message-State: APjAAAXmsWMRJB+Xm1u/m+cCU6KCnFxFZFM+BzZMiBcCF0Ui7Og+aWpn
        fEx4E6kSpHfnh6Fi3IXVgg3/aw==
X-Google-Smtp-Source: APXvYqztVaS1ibhclO02O+1c0xMIScuc0JduY91PsnnTXTwPY5JG40sHE+S7Y/qw2jdWh3mAfk9cAw==
X-Received: by 2002:a17:90a:480d:: with SMTP id a13mr45087965pjh.40.1559762240246;
        Wed, 05 Jun 2019 12:17:20 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id u7sm10218273pgl.64.2019.06.05.12.17.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 12:17:19 -0700 (PDT)
Subject: Re: properly communicate queue limits to the DMA layer
To:     Christoph Hellwig <hch@lst.de>
Cc:     Sebastian Ott <sebott@linux.ibm.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Max Gurtovoy <maxg@mellanox.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Oliver Neukum <oneukum@suse.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        megaraidlinux.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com,
        linux-hyperv@vger.kernel.org, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org
References: <20190605190836.32354-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <591cfa1e-fecb-7d00-c855-3b9eb8eb8a2a@kernel.dk>
Date:   Wed, 5 Jun 2019 13:17:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190605190836.32354-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 6/5/19 1:08 PM, Christoph Hellwig wrote:
> Hi Jens,
> 
> we've always had a bit of a problem communicating the block layer
> queue limits to the DMA layer, which needs to respect them when
> an IOMMU that could merge segments is used.  Unfortunately most
> drivers don't get this right.  Oddly enough we've been mostly
> getting away with it, although lately dma-debug has been catching
> a few of those issues.
> 
> The segment merging fix for devices with PRP-like structures seems
> to have escalated this a bit.  The first patch fixes the actual
> report from Sebastian, while the rest fix every drivers that appears
> to have the problem based on a code audit looking for drivers using
> blk_queue_max_segment_size, blk_queue_segment_boundary or
> blk_queue_virt_boundary and calling dma_map_sg eventually.  Note
> that for SCSI drivers I've taken the blk_queue_virt_boundary setting
> to the SCSI core, similar to how we did it for the other two settings
> a while ago.  This also deals with the fact that the DMA layer
> settings are on a per-device granularity, so the per-device settings
> in a few SCSI drivers can't actually work in an IOMMU environment.
> 
> It would be nice to eventually pass these limits as arguments to
> dma_map_sg, but that is a far too big series for the 5.2 merge
> window.

Since I'm heading out shortly and since I think this should make
the next -rc, I'll tentatively queue this up.

-- 
Jens Axboe

