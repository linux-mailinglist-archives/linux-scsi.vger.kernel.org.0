Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D048383E8
	for <lists+linux-scsi@lfdr.de>; Fri,  7 Jun 2019 07:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfFGFwk (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 7 Jun 2019 01:52:40 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33185 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbfFGFwj (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 7 Jun 2019 01:52:39 -0400
Received: by mail-wm1-f66.google.com with SMTP id h19so3273854wme.0
        for <linux-scsi@vger.kernel.org>; Thu, 06 Jun 2019 22:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=36gEkNDx0uUeJoUQsXVk3mt2cfXOtD54F9aZsyl2w8M=;
        b=pDdAAUOpVsFzxNwV4O/e7ssQLNLp50XAh3glMTxl5eSnaHqtKF1ESH20wwt4BLQ/kh
         BH7Od/RfACcOXYVEIHend3957AwdYma2TIl9/LqXUz4RFZcrNMzz27LkuDXjVjWNKTih
         ByCP8NoFt4Peya0Fp9Z21FaEJu/O+2bb8GCVNqttwksWr2+ZPc0cmapZ1Anup+ViBNTZ
         vjBIujh54ocCaeRN2S4DXdXQ718laVtBtLQxjNMDeXv9pj9WBm/YV9GRPDwOtdsA5mWJ
         krketIS//R+rWMkC2qjWZnfTvl0ZR5/Jjz7KOThnoVy/qaKx6I0jpjjmoalU/zkPP0pe
         +kUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=36gEkNDx0uUeJoUQsXVk3mt2cfXOtD54F9aZsyl2w8M=;
        b=A9rklm6Pb53IzbdsoZsEFpwMLibY23X+pNfVRrXytgjcKWEfvpKDo+6E5cSYUw+knC
         19QRc882j/+aqNifJHaapesqCqCKVO9r4RHU50i4lhibCOkyDZW1igcsm5jeeiX2cY0k
         ugYE9f5mc5pX1rMTFGGmLb8kDrPG4Ka3gKwrBY1lyJqRC066OiL2YOafc0nKL2Gnm303
         FRbg6j1mGz6nYIc1EmP/BPwCp1XghMOav+RojARQYiUDZ4Sm4Yu6BGTH8z3yZZVisgUy
         XqPwRrjWcF0+yjauuJ+wh7B5Fh0MorfZ9ihDO4tNMNhyS5JMkeYFgiapC0mjw5Q3JLTH
         2/fA==
X-Gm-Message-State: APjAAAVZfujKTJLrw0jhWBSQPO6J7XiJrvc7RTmvMpraek/7O2EzhZIH
        2ev6aYMbGydeM7xtg1PErpK3Cg==
X-Google-Smtp-Source: APXvYqxWfaiEDyUcmFI97Rqe1RFTEHA2+tg12ZBqTXrA/m0sqmbdeuwPeKLwpO4B0drdqMT3H41KnQ==
X-Received: by 2002:a05:600c:204c:: with SMTP id p12mr2244021wmg.121.1559886757922;
        Thu, 06 Jun 2019 22:52:37 -0700 (PDT)
Received: from [10.97.4.179] (aputeaux-682-1-82-78.w90-86.abo.wanadoo.fr. [90.86.61.78])
        by smtp.gmail.com with ESMTPSA id j15sm819336wrn.50.2019.06.06.22.52.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 22:52:37 -0700 (PDT)
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
 <591cfa1e-fecb-7d00-c855-3b9eb8eb8a2a@kernel.dk>
 <20190605192405.GA18243@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f07d0abf-b3eb-f530-37b9-e66454740b3f@kernel.dk>
Date:   Thu, 6 Jun 2019 23:52:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190605192405.GA18243@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 6/5/19 1:24 PM, Christoph Hellwig wrote:
> On Wed, Jun 05, 2019 at 01:17:15PM -0600, Jens Axboe wrote:
>> Since I'm heading out shortly and since I think this should make
>> the next -rc, I'll tentatively queue this up.
> 
> The SCSI bits will need a bit more review, and possibly tweaking
> fo megaraid and mpt3sas.  But they are really independent of the
> other patches, so maybe skip them for now and leave them for Martin
> to deal with.

I dropped the SCSI bits.

-- 
Jens Axboe

