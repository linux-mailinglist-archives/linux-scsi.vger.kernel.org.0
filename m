Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 166B92E9B1
	for <lists+linux-scsi@lfdr.de>; Thu, 30 May 2019 02:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbfE3AXn (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 May 2019 20:23:43 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34908 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbfE3AXn (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 29 May 2019 20:23:43 -0400
Received: by mail-pf1-f193.google.com with SMTP id d126so2740698pfd.2
        for <linux-scsi@vger.kernel.org>; Wed, 29 May 2019 17:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=dpN4wiii1TvSZMayJZekGyxBaLr+eeeO3Ruou2wN6wk=;
        b=Wm4oED+RlotHfcviCowYRWH7jw0M8K4gnkX4OOx30A/3cC7nN95j3QJ7f+r9ZfTpXw
         kAMMNMiHvTNlnDkGgIzqV2xzK2+MU8cGoVB+wibhXtWmVAFOG32U2AsRjEZZ+ao5hTSS
         Dfnb5mlnq1dVaAm037orKao9kDirTMAYVztlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=dpN4wiii1TvSZMayJZekGyxBaLr+eeeO3Ruou2wN6wk=;
        b=h/T3fnbQC5stR0LHWugyc/CSalQJK4JixS9lLjSUdV7WAugoeQckglGzwi1PXVN+ZJ
         YOS2G4s1eJxrjjCUVR8xsCOpIFRPPQtNKNJFhzkxXnIx0D2LDn7K2vQv1zdydmnRWfD7
         FI7DcLFA2sXEBallJJPnDo5z/GuA/JN5VJLT2TWEdNvQhOCYcFsui0BUtbEGC/GbxN6o
         7rSaF4K7NjmYrFRgF7Ys9VBUjLQ0GjOpYWFGoixRpvirG0u1bMrQl2EHXLRWQs3p5tgq
         5zhb9oEVU+g8HzReDJ40KhzwgkJ5Sdyvle8LAZGJCbOKA2T38JQp13No10i8eJO9InvR
         c8lQ==
X-Gm-Message-State: APjAAAWwH7egum2RjRDRTLFDQ22nn+bgG9PgI/7A/TKhrCemOm0vJYBD
        at3h98wKLDbpdRPaDxpoWUJ+oRFYUMs=
X-Google-Smtp-Source: APXvYqxb78UBEIoNeOotRBjD6CKuJJD04hvvXvpNzIsDfEycRQp9UICYuvcNF1lZu+YtPu0dCCG3uw==
X-Received: by 2002:a17:90a:be0b:: with SMTP id a11mr762957pjs.88.1559175822636;
        Wed, 29 May 2019 17:23:42 -0700 (PDT)
Received: from [10.69.37.149] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id s28sm446391pgl.88.2019.05.29.17.23.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 17:23:42 -0700 (PDT)
Subject: Re: [PATCH] scsi: lpfc: Use *_pool_zalloc rather than *_pool_alloc
To:     Thomas Meyer <thomas@m3y3r.de>, dick.kennedy@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1559161113889-196429735-0-diffsplit-thomas@m3y3r.de>
 <1559161113901-1017843021-1-diffsplit-thomas@m3y3r.de>
From:   James Smart <james.smart@broadcom.com>
Message-ID: <8e9198f2-1247-f7bc-7856-721664b64316@broadcom.com>
Date:   Wed, 29 May 2019 17:23:40 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1559161113901-1017843021-1-diffsplit-thomas@m3y3r.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org



On 5/29/2019 1:21 PM, Thomas Meyer wrote:
> Use *_pool_zalloc rather than *_pool_alloc followed by memset with 0.
>
> Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
> ---
>
>

looks good

Reviewed-by: James Smart <james.smart@broadcom.com>

-- james

