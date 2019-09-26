Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B227BF5FC
	for <lists+linux-scsi@lfdr.de>; Thu, 26 Sep 2019 17:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfIZPeq (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 26 Sep 2019 11:34:46 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33158 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfIZPeq (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 26 Sep 2019 11:34:46 -0400
Received: by mail-pg1-f194.google.com with SMTP id i30so1798200pgl.0;
        Thu, 26 Sep 2019 08:34:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nUrZ2yzOOS/mLgN4JcCBSk7/ekvqIf90P8kgkR3kovw=;
        b=aqdW0UxzCdvzBxbjiUT3idqrarwBM5/dTsHyR7JMFre/xSR78hBwrUm07WrrMZ+/It
         M00sPy2Iy4wfUkup/hzl8CyoTXr6Mj/T4FvNZ2EidQWmwysFUK4v1jE24e6ZltT2cxmD
         gFPJ6Si+OIc66gQdkmg0epbMdYg0FTu3a1jWPLRGc72urUd+0m95zC29AUv9132WPkuC
         bDFVOmJ5sW2hOLdj5P/OpVQQ6ExQEw42E/RpxL8gA/t1Ol/wquEKxHZgAY31oc1h+r47
         jj4fCfpUPtk8JeuKHfRcsXnpNMxQ+0LG1itM42Iv7VF9C4LIa0kxdI6wU9mzxl9KJ8BY
         ubCg==
X-Gm-Message-State: APjAAAUrUJLqEplKwcXh6iwLVFYZR+fP1aJHK2243572j2uPRX5NgMUH
        Fd6zN+dhHedLkEXqYb+g16Q=
X-Google-Smtp-Source: APXvYqz5TVXqKzZWUXWz+h12kHb8myYpmwjkB2/iVFk763NIiro4I/1xrGqkv/tmpcxsp8+LDu1NYw==
X-Received: by 2002:a63:350f:: with SMTP id c15mr92028pga.225.1569512084322;
        Thu, 26 Sep 2019 08:34:44 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id p88sm2739814pjp.22.2019.09.26.08.34.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2019 08:34:43 -0700 (PDT)
Subject: Re: [PATCH v2] scsi: core: Log SCSI command age with errors
To:     "Milan P. Gandhi" <mgandhi@redhat.com>, loberman@redhat.com,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com
References: <20190926052501.GA8352@machine1>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <8499ce39-211c-93ea-8127-195a7b4a9dd6@acm.org>
Date:   Thu, 26 Sep 2019 08:34:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190926052501.GA8352@machine1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 9/25/19 10:25 PM, Milan P. Gandhi wrote:
> Couple of users had requested to print the SCSI command age along
> with command failure errors. This is a small change, but allows
> users to get more important information about the command that was
> failed, it would help the users in debugging the command failures:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
