Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A82F53D6C9
	for <lists+linux-scsi@lfdr.de>; Tue, 11 Jun 2019 21:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404276AbfFKT1J convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-scsi@lfdr.de>); Tue, 11 Jun 2019 15:27:09 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39925 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387563AbfFKT1J (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 11 Jun 2019 15:27:09 -0400
Received: by mail-pl1-f193.google.com with SMTP id b7so489784pls.6
        for <linux-scsi@vger.kernel.org>; Tue, 11 Jun 2019 12:27:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qzW/WZev8ewao6A5QTrbl0+YO8e3SA4eQ83GmkeIJ9M=;
        b=WnU8XdX4BeQ1xPcIL+W5fFm7UzAdYikUQZct4uAsEU47e94GdmKZ9kOL8a4h22zARC
         0L1ZpLxu1TDoHxEFL8HUJ7n2hmnf2IKOeoD0FOPoiOgrV7eFqTNazHSoGg5GNXJrAyZ0
         YiLNlR3xxpmP+jhe5V4eOGdeX4KzmbgF/Qs7w3MoRzj04Wfnr7yI+7H6pOm47FQ+kJAD
         MENp9mtAVTb/y7+eVJKg4KdxSArVAgdAuP4mHKbLbVAySy2BzPEs+vXurQ9U6SahEZ1M
         s+QtSxage+G8xrUhUp/6YO4h7nf5nUdnkM64yfwGVHvkOxnwFEySgZzUU8O/+RiJHAwG
         2V6Q==
X-Gm-Message-State: APjAAAWSW8vVnpQ0bhxDI3dv6dqtW/WeafzDQ5Xe7DSJcvb0KutgqgEP
        NBht4z72Ubwr7Jq2WEVj5O8=
X-Google-Smtp-Source: APXvYqyGS/6GcQCoc/rx7QCM8HpA182ZZ+yeopLM7+uKE+VPPu4CT4YDOz5sAZMXc1HzNk42p2I/YQ==
X-Received: by 2002:a17:902:b43:: with SMTP id 61mr79361877plq.322.1560281228449;
        Tue, 11 Jun 2019 12:27:08 -0700 (PDT)
Received: from ?IPv6:2620:0:1008:1:f2c3:4898:1184:cd77? ([2620:0:1008:1:f2c3:4898:1184:cd77])
        by smtp.gmail.com with ESMTPSA id h6sm47619pjs.2.2019.06.11.12.27.07
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 12:27:07 -0700 (PDT)
Subject: Re: [EXT] [PATCH 00/20] qla2xxx Patches
To:     Himanshu Madhani <hmadhani@marvell.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
References: <20190529202826.204499-1-bvanassche@acm.org>
 <794547A0-2D81-42DD-8777-27B9BE607E21@marvell.com>
 <yq1y32fo4d9.fsf@oracle.com>
 <838DE773-DCD5-40CA-933C-1FF88399AF6C@marvell.com>
 <yq1o93aml62.fsf@oracle.com>
 <BF5C02E6-89E5-493E-953A-A34B196BBD30@marvell.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <c981ce78-e9d6-0d9f-ef17-385de6eb37f6@acm.org>
Date:   Tue, 11 Jun 2019 12:27:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <BF5C02E6-89E5-493E-953A-A34B196BBD30@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 6/11/19 11:12 AM, Himanshu Madhani wrote:
> I am running into issue with this series applied on my tree while executing abort path. 
> 
> Investigating if the issue is introduced by this series or not.
> 
> stack trace does not have qla2xxx signature but since this series has changes for abort path I am holding off on providing 
> ACK on this series until we fully understand what is triggering issue.

Hi Himanshu,

Can you share that stack trace such that I can help analyzing it?

You may want to know that I have another patch series ready with bug
fixes that I have not yet posted because I was waiting for feedback on
this patch series.

Thanks,

Bart.

