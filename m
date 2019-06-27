Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C208B57E13
	for <lists+linux-scsi@lfdr.de>; Thu, 27 Jun 2019 10:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfF0IRs (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 27 Jun 2019 04:17:48 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38411 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbfF0IRs (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 27 Jun 2019 04:17:48 -0400
Received: by mail-wm1-f67.google.com with SMTP id s15so4680916wmj.3
        for <linux-scsi@vger.kernel.org>; Thu, 27 Jun 2019 01:17:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RmjFFyBvDQn6Xfu0Q/BuVkvS+UCn+TuhSSD5OUjhRJI=;
        b=g12CCmmCoUpUFQPFxF1r9SbD0kYUDxxnS2n+p/2FZyXXrIMATJZTjJBL1VAwS+94K6
         J6hYr3TpEpeLLLI0K3Ac866+E+WJmMjLX2B6cyrsfu47IEaiBqZ/GB5ke1OAkkb04qkD
         qA0xMVFac5rCECR9XgVlDBRVbE3K1x4k104j1EMnEcu6E9FBISOMvl6WKiEliyXse1BQ
         Ht+/a02PeB+N4z8gzbYRZtDG7fi9t3iWrl/p9ViLZ30NJQTnLee4uFekATxkeaQ3eI9q
         vu1+vKlpPKu4idJtvCNquCShR36uwsj2kP6GPRDsghc7nsPwi4dqPnItrA7ZzRVMgSls
         Zh1g==
X-Gm-Message-State: APjAAAWh47cHz9yR6DjkAO1u7EVH8Ht6ZdaUNZk6V/3pQOzyP/9MWd0u
        2pcfBsMUmTBDtt4igTs8GlbiBw==
X-Google-Smtp-Source: APXvYqz3R18OS3WEjLZ+sqKqP/ULCckrvtGOJ16Yd4BZO4NaYsCWsUcLjTip7leqUVtkXS2VltM4KA==
X-Received: by 2002:a7b:c3d5:: with SMTP id t21mr2010355wmj.87.1561623466915;
        Thu, 27 Jun 2019 01:17:46 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:41bc:c7e6:75c9:c69f? ([2001:b07:6468:f312:41bc:c7e6:75c9:c69f])
        by smtp.gmail.com with ESMTPSA id i25sm1753308wrc.91.2019.06.27.01.17.45
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 01:17:46 -0700 (PDT)
Subject: Re: [PATCH 0/2] scsi: add support for request batching
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        jejb@linux.ibm.com, linux-scsi@vger.kernel.org, stefanha@redhat.com
References: <20190530112811.3066-1-pbonzini@redhat.com>
 <746ad64a-4047-1597-a0d4-f14f3529cc19@redhat.com>
 <yq1lfxnk8ar.fsf@oracle.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <48c7d581-6ec8-260a-b4ba-217aef516305@redhat.com>
Date:   Thu, 27 Jun 2019 10:17:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <yq1lfxnk8ar.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 27/06/19 05:37, Martin K. Petersen wrote:
>> Ping?  Are there any more objections?
> It's a core change so we'll need some more reviews. I suggest you
> resubmit.

Resubmit exactly the same patches?

Paolo
