Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D99C334C2
	for <lists+linux-scsi@lfdr.de>; Mon,  3 Jun 2019 18:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729109AbfFCQTg (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 3 Jun 2019 12:19:36 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43797 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728902AbfFCQTg (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 3 Jun 2019 12:19:36 -0400
Received: by mail-pf1-f196.google.com with SMTP id c6so10893833pfa.10
        for <linux-scsi@vger.kernel.org>; Mon, 03 Jun 2019 09:19:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G3tgbdone2G8gkPyy1LFnMrFQlCAl/D+gkpfWbIv56I=;
        b=ZpB0HYlf6a5WpADl2Sx1y7v21XCndlepOdzK0Fcz7y4ucUG83j4G0MIKbybmAtnpCX
         pL1gTJcsq83oSP8hptymaZtOZE9kKrmx8g85f/r2sYrw4KTsw2dZZOyqSbB2O9XUnZFX
         ObciyhO4SNgTRlGWlU9LC07CCBsEE+DDFRvdUp5Y1ISr9+C/wAWoXUYbOZdSTqp9hJ2g
         vvI0x+q/oTnW9M7vzB7F9aY9dSQ8frMiEOHB8YiL1Gpwdpy4CPFw+p9aMR06GyUJ8CSn
         KpAJYmsufUOtuqry8fUaxMajmwLXqk3HuQcO+aexOkJzpDCNKrsMWONYH7QEb7gY8+T9
         AA2Q==
X-Gm-Message-State: APjAAAUNuGxRaePrtezjIr2TUjIhozxNmCNSMrEiZa4s/gzXSyo1NzZg
        zdJ9SbPEPp8SsAgerkc0u0M=
X-Google-Smtp-Source: APXvYqwIEtCoJ+aZTuu73GPMI9wvt/9GLSYOlqSwja6BI/Dz9DRoRc3K0ohOdBCL59ud8NXSLgfSEQ==
X-Received: by 2002:a62:e417:: with SMTP id r23mr1533986pfh.160.1559578775719;
        Mon, 03 Jun 2019 09:19:35 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id 139sm3854724pfw.152.2019.06.03.09.19.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 09:19:34 -0700 (PDT)
Subject: Re: [PATCH 00/19] sg: v4 interface, rq sharing + multiple rqs
To:     Douglas Gilbert <dgilbert@interlog.com>, linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de,
        bart.vanassche@wdc.com
References: <20190524184809.25121-1-dgilbert@interlog.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <038d4781-1762-d7f6-199d-2f4702e746f6@acm.org>
Date:   Mon, 3 Jun 2019 09:19:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190524184809.25121-1-dgilbert@interlog.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 5/24/19 11:47 AM, Douglas Gilbert wrote:
> This patchset is big and can be regarded as a driver rewrite. The
> number of lines increases from around 3000 to over 6000.

Every SCSI reviewer I know is too busy to review a patch series that 
involves so many changes. You may have to split this series into a 
number of smaller series if you want to encourage reviewers to have a look.

Bart.
