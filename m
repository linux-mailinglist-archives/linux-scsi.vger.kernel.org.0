Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E216077355
	for <lists+linux-scsi@lfdr.de>; Fri, 26 Jul 2019 23:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbfGZVWG (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 26 Jul 2019 17:22:06 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42552 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727398AbfGZVWF (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 26 Jul 2019 17:22:05 -0400
Received: by mail-pg1-f194.google.com with SMTP id t132so25327754pgb.9
        for <linux-scsi@vger.kernel.org>; Fri, 26 Jul 2019 14:22:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=scCikGkBFej7LxHyUYZ2fXl9QCAqibYPgXCdAA0tuVM=;
        b=W47VhMmOIpYlqY0ug0AeDdC0kZujoWx4SzAO7R7rymLWazWRkEycGOtvWJvD+REEQb
         5GyY2pC6A1aBY0Tymx24zgaZ+0RlftJvLvNea2SQQemIfo2+OElcxJcry7Krx4/lYiz8
         smBT+TCSjncvh4yIdjADNxp1B9opudAn0kEgekD9NrE+b85RUlC0Oe38JaftKXYX0wXe
         TzDHEYHdfB8W/gr4DavhRYUkHLp4Qc9y2yjF/r2xd2oW0InM1kglrMqvWA7FSbOGSk42
         aJAM/ddLs5YmPKbn5cicBYm2v5VR6aH1ijyBrA8/lkUGvfQokddAihJAq47MIB6ddQcf
         8s9Q==
X-Gm-Message-State: APjAAAV1lacK03jfgXvyokLXsjeuK4DDJGdC1XbHiUt2laZt/a70OGnH
        ccZq/KzUOs9wOETJFw5/L9s=
X-Google-Smtp-Source: APXvYqw5tdFIGWOlVFetD2i/XPCjdqq28Fer0L0QN5HFbjncwMG1m3k1gYhIWd4XtV6WiBev46kh7w==
X-Received: by 2002:a63:7245:: with SMTP id c5mr79653973pgn.11.1564176124807;
        Fri, 26 Jul 2019 14:22:04 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id b36sm81264408pjc.16.2019.07.26.14.22.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jul 2019 14:22:03 -0700 (PDT)
Subject: Re: [PATCH 3/4] Complain if scsi_target_block() fails
To:     James Bottomley <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Ming Lei <ming.lei@redhat.com>
References: <20190726164855.130084-1-bvanassche@acm.org>
 <20190726164855.130084-4-bvanassche@acm.org>
 <1564160404.9950.1.camel@linux.vnet.ibm.com>
 <210a31fb-37d1-93ab-c339-f8cc410f65d7@acm.org>
 <1564164203.9950.5.camel@linux.vnet.ibm.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <b3dd403e-b85b-2db9-65b5-268fa7553204@acm.org>
Date:   Fri, 26 Jul 2019 14:22:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1564164203.9950.5.camel@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 7/26/19 11:03 AM, James Bottomley wrote:
> I don't disagree, but nothing in this patch set actually uses it ... is
> there a plan for something to use the scsi_target_block return value to
> perform some action other than issue a warning?   If not, it likely
> makes better sense simply to add the warn once to the device block ...
> unless there's some problem that might make it too verbose for a target
> (say 100 devices each of which would issue the warning).

Hi James,

I will drop patch 2/4 from this series and implement what you suggested.

Bart.
