Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92578EC671
	for <lists+linux-scsi@lfdr.de>; Fri,  1 Nov 2019 17:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbfKAQPW (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 1 Nov 2019 12:15:22 -0400
Received: from mail-pl1-f171.google.com ([209.85.214.171]:35509 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbfKAQPW (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 1 Nov 2019 12:15:22 -0400
Received: by mail-pl1-f171.google.com with SMTP id x6so4585217pln.2
        for <linux-scsi@vger.kernel.org>; Fri, 01 Nov 2019 09:15:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EK99p/hI6Iomb+BRrmhgdpt5dZ6gQMHqohmDfLJTI90=;
        b=LU85j6qFT4Sxr41ZchjLhoZ00WWsE+JXjgyMeU4uNTJQjV6fop8aBDBNWmrwljfjF4
         Ps3BHA6A7Jaikj1GI/1Uvr+mHxGandCX4SER8z5ouc9CSbyFRkN3nlDXLJ3GVuUpWUjn
         kVirxGDOMXZrkkKhScwkdpCnwDwanisJDmFLVjCSjTjNkNKMbUjs1zAadbxkvj54yStx
         76908xnHKxl4D7g2qNgvXSjm2c7IOzjRk9bh20h6AllbiDnQ8/cPG8P9mRUV1Og2t0IQ
         UPdP1vmHcNiK44EOzFwllEPraPXeC/5iEOoeOkW0gh1XeLmfrVPTVj92/fE2LO+/cLsx
         5SGQ==
X-Gm-Message-State: APjAAAV3HET8+IOHQOEEDmnL9Ls1OWlHs14NL5iF7k1YXbE/SaHnYhVi
        20qFs0O+sEiNqAWitom6T9TH/8iFMT0=
X-Google-Smtp-Source: APXvYqw4YQ9TwObyPMf91q8R68vRMoDitSDObrHs2EfqnLVi+C8MbMaZr3q8AjWDJWV7tRQT5xVfgg==
X-Received: by 2002:a17:902:5ace:: with SMTP id g14mr6184853plm.73.1572624920632;
        Fri, 01 Nov 2019 09:15:20 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id b82sm6939517pfb.33.2019.11.01.09.15.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Nov 2019 09:15:19 -0700 (PDT)
Subject: Re: [PATCH 02/24] bfa: drop driver-defined SCSI status codes
To:     Hannes Reinecke <hare@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org
References: <20191031110452.73463-1-hare@suse.de>
 <20191031110452.73463-3-hare@suse.de>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <56726c10-6bab-2153-29fc-8746ac7d8e36@acm.org>
Date:   Fri, 1 Nov 2019 09:15:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191031110452.73463-3-hare@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 10/31/19 4:04 AM, Hannes Reinecke wrote:
> Drop the driver-defined SCSI status code and use the generic ones
> instead.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
