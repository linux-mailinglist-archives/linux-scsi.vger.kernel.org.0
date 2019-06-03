Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8972932736
	for <lists+linux-scsi@lfdr.de>; Mon,  3 Jun 2019 06:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbfFCEYx (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 3 Jun 2019 00:24:53 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40993 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbfFCEYx (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 3 Jun 2019 00:24:53 -0400
Received: by mail-pg1-f193.google.com with SMTP id 83so683360pgg.8
        for <linux-scsi@vger.kernel.org>; Sun, 02 Jun 2019 21:24:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WqdNmgMM8IjeNY8AGLuBTWKC+Ee4xrFdSZ6RGrKuQ0g=;
        b=kkHqx7azKwlOJw9oh92IYJNpIiY1gZu1GAlbKBw3/Nqg6TDjZrE2z55S20qv4zuKy3
         rgIdx4t1aNEIiB0k8sYX9JL4PR1KPbbT35BdupQL3s50of8EnLEY+aR3Xy/7WSJp7vHh
         m0tL6ofytq+TC5muEtaIOsF9mvISBHS5nIG1jwOKc/uoBylyE6rjRBUU6ZE7YAVlJdeR
         AaPrqTYwOYbfoTL4xtMNdFp2cxwywDP3ZcVrrkV0thFfW1K5i/4zD/BPP8Wu3kDVyCzu
         O6jwmLc2ngJEWskPkUTKuRmIoh7ldJl5ViLROFg04V7uytdepI21lGJbpEL6Idz7KzEU
         vbzg==
X-Gm-Message-State: APjAAAVQ/XFYQ/SKzhNCj+/9BxCpn5PGdvQFWtAAHtFb4cMY2Y6bdwwy
        /xf/yQ0v4nTGb1wJKb1QXDg=
X-Google-Smtp-Source: APXvYqyXrolW+hOVeRr6lCGshdwUUhd7LFCWBwJVcRXyxVSFr9e2BMpvZGcn2zzpNfSAdrSO46Z3ug==
X-Received: by 2002:a65:6089:: with SMTP id t9mr5459621pgu.170.1559535892799;
        Sun, 02 Jun 2019 21:24:52 -0700 (PDT)
Received: from asus.site ([2601:647:4000:5dd1:a41e:80b4:deb3:fb66])
        by smtp.gmail.com with ESMTPSA id d2sm11438778pfh.115.2019.06.02.21.24.51
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Jun 2019 21:24:52 -0700 (PDT)
Subject: Re: [PATCH 00/19] sg: v4 interface, rq sharing + multiple rqs
To:     dgilbert@interlog.com, linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de,
        bart.vanassche@wdc.com
References: <20190524184809.25121-1-dgilbert@interlog.com>
 <a1096ff2-71f5-f398-6173-c8832ac7e26c@acm.org>
 <1c706e3c-6195-a84b-ac70-f15e5e55e9a7@interlog.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <fa00fd13-e5aa-ea49-d792-351e53bb74b0@acm.org>
Date:   Sun, 2 Jun 2019 21:24:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1c706e3c-6195-a84b-ac70-f15e5e55e9a7@interlog.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 6/2/19 1:23 PM, Douglas Gilbert wrote:
> On 2019-05-26 11:49 a.m., Bart Van Assche wrote:
>> On 5/24/19 11:47 AM, Douglas Gilbert wrote:
>>> This patchset restores some functionality that was in the v2 driver
>>> version and has been broken by some external patch in the interim
>>> period (20 years).
>>
>> What is an "external patch"?
> 
> It's a patch made by someone with a first name like Christoph, Jens or
> James (picking some names at random) that is applied whether or not
> the maintainer of said driver approves ("ack's) or not.
> 
> IMO The maintainer should be able to restore features removed in this
> fashion (I'm talking specifically about the neutering of
> SG_FLAG_NO_DXFER) without review as it is in the documented interface.
> Plus I know of at least one power user who was peeved to find out that
> it was quietly broken.

That's unfortunate that that regression happened. As you probably know 
the traditional approach to address a regression is to post a fix that 
has the "Fixes:" and "Cc: stable" tags.

Bart.
