Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E4B6A9E5D
	for <lists+linux-scsi@lfdr.de>; Fri,  3 Mar 2023 19:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbjCCSVg (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 3 Mar 2023 13:21:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbjCCSVe (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 3 Mar 2023 13:21:34 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2137B1040E
        for <linux-scsi@vger.kernel.org>; Fri,  3 Mar 2023 10:21:33 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id ay14so10153367edb.11
        for <linux-scsi@vger.kernel.org>; Fri, 03 Mar 2023 10:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677867691;
        h=content-transfer-encoding:to:subject:content-language:reply-to
         :user-agent:mime-version:date:message-id:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LaOTBtKMwRZiDcFQS8k/nw3O839PhUwgA/MLGTdCM4Q=;
        b=AzW+6Up9k3tTaluNvAnojBerFXyjIQ1glm8UcMbP+kEZGjFQr0zacLLC9uB9URr8s7
         /F7etEHGavrwmU/wgSzxhubOHdjc2BkTxl+UJgV2mkzCPsvHy3/xpj4NBjgHoSABFaWW
         tTb43YiAjoxFgiCtBRTH2x7Kv7qXdzADn1fNV97Op1yHDdeGn7b3M6wI/LQ583MdMWhq
         p4E0FCHjWeVS2xfzeTSCHsuBq+XLhwWQ7DTVP72EphnHJzoMFYgWXek8ounOIkQHhp/3
         l7o/NJmDwDvNTWfYeLArJgSkYNOesUHFe+9LxwKJtpSuzeC/irfmlprpxfVMCUbiwDQu
         f87w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677867691;
        h=content-transfer-encoding:to:subject:content-language:reply-to
         :user-agent:mime-version:date:message-id:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LaOTBtKMwRZiDcFQS8k/nw3O839PhUwgA/MLGTdCM4Q=;
        b=M97l5SRD5S8/j1If1b/wsW4AD6yqG6E3jnxFjSjgBBbK+fXFBI50S6c0xHmwznICxE
         X/dEQwg3IbaoYfZvSYq/GHb0Tf/v7+dI4D4+gJLmUc1T7HyuNxG4cTnQiWK70xQ7GgZb
         wd6pc4+sTUz2V1yhaHy4rUpZa36fYhT/avG3EA9PDOZQ8D11iP9W7PUZVql2qP6lYMgA
         j1k4hBPIZ0o7/KedgBwl0dUq+nAgGEWDXlcxSfgGNGFGIiFO+HLFVw4wRFekOcpwQHnW
         bT/ccwmJ20cQoKNc429xxXf14hH2V2J9Yix74IYISBTkIQ559AK9D2kkYNwCYK0oGDQr
         Aw1g==
X-Gm-Message-State: AO0yUKUj5VpMdFRiL/xdfIJrIaV6YmA+xhgj4xX/Y9GzpXgucHREkB2Z
        qAV2eVtrceqCdQiZJ068jZw=
X-Google-Smtp-Source: AK7set+SiDAvwAeR0NqH+UDuy9dbcVK9kIHz7ert1Q2N7srhVYmjGwvRH6z6aWBKC0JHkSY5D7kXPA==
X-Received: by 2002:a17:906:20c6:b0:8f0:ba09:4abe with SMTP id c6-20020a17090620c600b008f0ba094abemr2557321ejc.2.1677867691336;
        Fri, 03 Mar 2023 10:21:31 -0800 (PST)
Received: from [14.2.2.97] ([196.171.80.178])
        by smtp.gmail.com with ESMTPSA id 23-20020a170906005700b008e3e2b6a9adsm1202181ejg.94.2023.03.03.10.20.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 10:21:30 -0800 (PST)
From:   Elom Amegbley <afodinkpa.nwankpa9504@gmail.com>
X-Google-Original-From: Elom Amegbley <afodinkpanwankpa9504@googlemail.com>
Message-ID: <6a3f0248-419b-e0cd-5b44-39ed4e8095e8@googlemail.com>
Date:   Fri, 3 Mar 2023 18:19:31 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Reply-To: emailoffice151@gmail.com
Content-Language: en-US
Subject: Re:
To:     undisclosed-recipients:;
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: Yes, score=7.7 required=5.0 tests=BAYES_50,DEAR_FRIEND,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:530 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4816]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [emailoffice151[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [afodinkpa.nwankpa9504[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [afodinkpa.nwankpa9504[at]gmail.com]
        *  2.6 DEAR_FRIEND BODY: Dear Friend? That's not very dear!
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  3.0 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Dear Friend,

With due humility; I sent you an email and there was no response, please
confirm to me that you did get this mail for more clarification.

Kind regards,
Yours in service.

