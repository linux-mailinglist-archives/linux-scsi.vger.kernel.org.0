Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48822156F0
	for <lists+linux-scsi@lfdr.de>; Tue,  7 May 2019 02:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbfEGA14 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 6 May 2019 20:27:56 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45785 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbfEGA14 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 6 May 2019 20:27:56 -0400
Received: by mail-pf1-f195.google.com with SMTP id e24so7625615pfi.12
        for <linux-scsi@vger.kernel.org>; Mon, 06 May 2019 17:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=oCmxPoESpcTiWrVKRfb+VwwaMM4dpS5uE3CUmDAu+ag=;
        b=MRgAdZdqOxtTUCP1ZZ3zDgArbRgx1IAs0kf85fp0Dg5NJTKNfNS2Xsf3FxBBntzVGQ
         HMi5N9I+d80Ge/jqigk56NzEm/rEeFlZd+I+3lqQe6fPq4MCrM4tgj6H2aNSByzSeUkL
         WLk9ZRGwf36CbM7kxw2n7x+9fXkqZdEhnZgNCrG4JWONjWGY2PuQS0Gz7mVfMdRnRUeV
         dubrlNhQNxLU2g39PhZW9peQRx20TOGfgNGP7iYFZj2ynX+ofKHhkzv3vLubsJiRkf4z
         iaymA2+aqZO33job9xbDJLc5ds9IYQVN4Yhu7e+pKC9zF8CWdS7lRqJVzQ0G+0rA0ywE
         GTmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oCmxPoESpcTiWrVKRfb+VwwaMM4dpS5uE3CUmDAu+ag=;
        b=CVfjbhAk7UH+zApfM6Lr4VP8DxLi2cEy4ELflWGR2OMsJHpJKH+XkLduvIYyuXgKEN
         GsIm2iEHdclwNMuxjuV0KkrVq53Vg8TRAuTugMvohbuo4obXa2hJtvEqSAwY8G6BmbyV
         21BVpcaVUNwV37MD6rQLMaeS/C2VHsOIeOFNsA5K2qGdIQJ7yXODloS9Rtfiok+0KgaV
         YQOmLcsCjizqoQLxgqiyVZTeESDiXMt3+ZKnRGZ18gTpCHFEoDrtBDNlH3Hqr3Z5c+nb
         PJJcX3CRWRoirS6oQakburTmNwWaN7WLvC2jLPyPTx+n8RdynmeeV4LS9GvyffnMaxej
         YZgg==
X-Gm-Message-State: APjAAAXBSWKY68TZx/K0Bc4bvgYmO8YzK3pRlcsy6spo8imAt/jbP1Xo
        x854BcvRU+kQulra5UYdgFyTRQxn
X-Google-Smtp-Source: APXvYqzc+tFVVGaS360+AKXMnVa3ygMsWZFYxVMBGCEElok1AEnd7qRHh3OaZDuPJ63UPxpjdA+vtg==
X-Received: by 2002:a62:e10f:: with SMTP id q15mr37677817pfh.56.1557188875662;
        Mon, 06 May 2019 17:27:55 -0700 (PDT)
Received: from [10.69.37.149] ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id n15sm25694208pfb.111.2019.05.06.17.27.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 17:27:55 -0700 (PDT)
Subject: Re: [PATCH 0/4] lpfc updated for 12.2.0.2
To:     Bart Van Assche <bvanassche@acm.org>, linux-scsi@vger.kernel.org
References: <20190501175926.4551-1-jsmart2021@gmail.com>
 <8b11d5d2-fe7c-14c6-7224-3d0ec824f432@acm.org>
From:   James Smart <jsmart2021@gmail.com>
Message-ID: <3f1d88db-1388-033c-9c02-d1d2189c7708@gmail.com>
Date:   Mon, 6 May 2019 17:27:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <8b11d5d2-fe7c-14c6-7224-3d0ec824f432@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 5/3/2019 8:17 PM, Bart Van Assche wrote:
> On 5/1/19 10:59 AM, James Smart wrote:
>> Update lpfc to revision 12.2.0.2
>>
>> A quick patch set that resolves lockdep checking issues and
>> addresses a couple of bugs found when inspecting the paths
>> for the lockdeps.
>>
>> The patches were cut against Martin's 5.2/scsi-queue tree
> 
> Hi James,
> 
> While testing this patch series I hit the kernel warning shown below. Is
> this kernel warning perhaps a regression due to patch 1/4 in this series?
> 
> Thanks,
> 
> Bart.

Should be covered by v2 of patch1.

-- james

