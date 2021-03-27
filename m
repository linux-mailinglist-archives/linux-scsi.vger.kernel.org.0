Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA0E34B815
	for <lists+linux-scsi@lfdr.de>; Sat, 27 Mar 2021 17:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbhC0QBn (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 27 Mar 2021 12:01:43 -0400
Received: from mail-pj1-f43.google.com ([209.85.216.43]:53107 "EHLO
        mail-pj1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbhC0QBl (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 27 Mar 2021 12:01:41 -0400
Received: by mail-pj1-f43.google.com with SMTP id ha17so3996402pjb.2;
        Sat, 27 Mar 2021 09:01:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r8IFasUqsYTP3uxX6n62giQBLbCojhO6vBKD44pvhZk=;
        b=M9+Wzpg/h/y5pRP444B0k8RqyiMAW/usIkcHXGxCGYziah54SAtB58rfttgVW3Ubw2
         bTuhQ5AOiibnbmRSP8ViZ/Oese0YddR5UB/QvQGzYUUARKqXMjUo0eTk4CV+YnI2tpTu
         sOQ3JfDhyZP73WwrH0QqLH32plykNqhOxeHKYLkoGFTkPx4A/Ssyk1a48minVXwxel1U
         k7q5xj7dSG9RTdwtf+cg+iRXV47sDf9kDre+kpmOYkG+bbVuOJESmKuy9JG5VEP+Ixur
         FK99lXKjPK8R1gakWejMckSQyGHWGtsB1gWhrWIdOERAJOSEy5kW4swDqctL9AwNDGXw
         wpVw==
X-Gm-Message-State: AOAM5325FiAgiZatmGiWv5aTiWFpGllgzObZ00L+wWfAoSxtgGbM2re+
        pUfYupoXeH23Mi4Dtd7RVagFGQti3yQ=
X-Google-Smtp-Source: ABdhPJx+0sp0AOs5GPIFSBnOTZvxjDAiX9Y9Ld8kyCG14dSzqsPwXzFOoGn50O4SMaqfpzoanLHrMw==
X-Received: by 2002:a17:902:8687:b029:e6:5eda:c3a8 with SMTP id g7-20020a1709028687b02900e65edac3a8mr20421722plo.59.1616860900712;
        Sat, 27 Mar 2021 09:01:40 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:250c:9f5c:fb74:abf7? ([2601:647:4000:d7:250c:9f5c:fb74:abf7])
        by smtp.gmail.com with ESMTPSA id z1sm12684190pfn.127.2021.03.27.09.01.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Mar 2021 09:01:39 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] scsi: add runtime PM workaround for SD cardreaders
To:     Martin Kepplinger <martin.kepplinger@puri.sm>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stern@rowland.harvard.edu
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210112093329.3639-1-martin.kepplinger@puri.sm>
 <9d0042fbfba9d33315f9eee7448b60aca8949431.camel@puri.sm>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <147104aa-1040-3632-6fed-9e6c584c3561@acm.org>
Date:   Sat, 27 Mar 2021 09:01:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <9d0042fbfba9d33315f9eee7448b60aca8949431.camel@puri.sm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 3/27/21 3:48 AM, Martin Kepplinger wrote:
> since this is absolutely needed for runtime pm with the SD device we
> use I assume there are others that would benefit from this too. Do you
> have any concerns or thoughts about this (logic and interface)?

Hi Martin,

Since the issue addressed by this patch series concerns a controller
bug, please use the SCSI core BLIST mechanism instead of introducing a
new sysfs attribute. A sysfs attribute could be misconfigured. BLIST
attributes however are set from inside the kernel and hence do not need
help from userspace. See e.g. c360652006bb ("scsi: devinfo:
BLIST_RETRY_ASC_C1 for Fujitsu ETERNUS").

Thanks,

Bart.
