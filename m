Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03780390CD
	for <lists+linux-scsi@lfdr.de>; Fri,  7 Jun 2019 17:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731362AbfFGPqQ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 7 Jun 2019 11:46:16 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:32783 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731349AbfFGPqP (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 7 Jun 2019 11:46:15 -0400
Received: by mail-pf1-f194.google.com with SMTP id x15so1441656pfq.0
        for <linux-scsi@vger.kernel.org>; Fri, 07 Jun 2019 08:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=31vMQU4RIkbKy4hbseIDlylLGLp/XADycJXpgSVuDr4=;
        b=Ne97Z8QnQgmdt0btIhdseWs+yJ7us+ZcShdM9OiC3LZFzSudIgqeut9KGXWRdYXGHI
         ZcRXD+SILdRZ1DTPUSylZOwAWw3x4Kf6xU8CjoJGP60Mqf72OOdAAm3wIOOqAzJWIury
         lHptEcLYFegRT/eAnR2iykGyi7Op3Scfsx7pM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=31vMQU4RIkbKy4hbseIDlylLGLp/XADycJXpgSVuDr4=;
        b=A9Xfs3ieL9cxKn3SYpTfsg0ZEf5GzZ6IroInWym7oypc5SV6yyh87T4ngPAWJQrCSP
         hymL5X0yb6Owls3ZQqxgs4Y1tPNnZF5snCh9hML7P4j6BevdkaZAwwR3a/yJILDGE5eR
         5GNAoRb55YB+B4oq2gX0dgqf4m8YT3zt5cvREmYBk5Amk30GABDWCh1sW0+6qZrUTNwM
         j4U6CeXF3BWYU+Yr71PZbXSwruiTDBBCgtuq5CCxkQaLjRe+hLomzFbm3Xg5eXk7cwQx
         WFckphkI7TKdAVem5HP978wyYftjyQ0GPf92Fm2iqBK7cpzKWvEvSkpzbbxnkHFSqE+C
         J5tw==
X-Gm-Message-State: APjAAAWPxVrlnjSwCczV/Yp0BrIZgjgKOtZRIcBWUTlVyiiQ3Qi9TLXh
        X4j3zaYNJ1o8p+G+bUcfrZevzw==
X-Google-Smtp-Source: APXvYqytqbpQupqK4sIXZZMcSZJ0OYESK8ar46H/Ybi8orJWhgG98lq9xEnNmWJfxuzHlDLoI0pmMA==
X-Received: by 2002:a62:d11d:: with SMTP id z29mr6329476pfg.21.1559922374784;
        Fri, 07 Jun 2019 08:46:14 -0700 (PDT)
Received: from [10.69.37.149] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id r77sm3236886pgr.93.2019.06.07.08.46.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 08:46:13 -0700 (PDT)
Subject: Re: [PATCH 1/3] scsi: Do not allow user space to change the SCSI
 device state into SDEV_BLOCK
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
References: <20190605201435.233701-1-bvanassche@acm.org>
 <20190605201435.233701-2-bvanassche@acm.org>
 <cec3e805-c834-a389-9666-bb79ed86057d@suse.de>
 <22ce1f30-a3c5-fc7d-0f1e-e2ca589682bb@acm.org>
 <470d4c41-1f9e-730e-a1dc-a27f9e971bc1@suse.com> <yq1tvd1lgql.fsf@oracle.com>
From:   James Smart <james.smart@broadcom.com>
Message-ID: <d7d48fc4-9df6-74d1-f308-bf5a9d8ef0a7@broadcom.com>
Date:   Fri, 7 Jun 2019 08:46:07 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <yq1tvd1lgql.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 6/7/2019 5:30 AM, Martin K. Petersen wrote:
> Hannes,
>
>> So let's restrict userspace to only ever setting 'RUNNING' or
>> 'OFFLINE'.  None of the other states make sense to set from userspace.
> Yes, please!
>

+1 for me too
