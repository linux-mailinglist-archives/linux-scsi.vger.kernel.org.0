Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F21D54875D5
	for <lists+linux-scsi@lfdr.de>; Fri,  7 Jan 2022 11:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237129AbiAGKpG (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 7 Jan 2022 05:45:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236787AbiAGKpG (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 7 Jan 2022 05:45:06 -0500
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99564C061245
        for <linux-scsi@vger.kernel.org>; Fri,  7 Jan 2022 02:45:05 -0800 (PST)
Received: by mail-ua1-x942.google.com with SMTP id x33so8053807uad.12
        for <linux-scsi@vger.kernel.org>; Fri, 07 Jan 2022 02:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=avOzz+s5zjOOJ9Z2Kb6BjAYu3bmaGVtVbqQU0g+1drQ=;
        b=MHvALfZWbeGMW0CHUE61ffpR7+tC5tHm/ZXlRbpWuKypTopn4H1pq0fx++s4DYI+cQ
         P0BbVDBSVebXf9CvF3WcwhP1u+JpmXtywGXiUzCRED6OL4yl9AIHafaVe1xXktRRXnPQ
         WJ6UdxLpgAvfjqARu2Spc4ugvjC9zGRMlkr+93Y4zaivIakB9uBS8+Fqs/DlwqATg0Gg
         pPKh/Isf4EavNsERWLfcATAx+1Se3MBe0EHwgBhmTHmSP94Vxe1rNO0PVUK01dHSp3g8
         12avC7K2WElZrc2M+Zf/Q7gloDm8IOYL1hKAUNx6tlGp9vEUlL0GIyB8r0JVu6gMxJUk
         0qsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=avOzz+s5zjOOJ9Z2Kb6BjAYu3bmaGVtVbqQU0g+1drQ=;
        b=g+WPxVg1c8T6c0Sd30zvSFRsllWaJaej4nlKiGbJdVZuto1O9GOdjOnGl99LrYouwH
         On/hla/QOGOJvLAhLuVuY1cIvh8zvdnl2VMJPbL9+L2mJhRIojmgsA4q9c1JeG4MRFZ+
         YENSiBpBZth86sct0jpTXplT9RblDKS89jLBMiyZipcc5jqE3OlRw9KVm4SMRCgyxklC
         lzpo1/nORVQO9xQMbjV6Tfra+gyoDw5+aBi09z6foWduEmimL7xonlMCo0CPGtG56T9K
         bZm0C7RANVRWHq9hk+XytvXJV49RbrSjBDnlD4oP9aaRpgf6bc9iTnMTkN+7BRDhjEbQ
         iePg==
X-Gm-Message-State: AOAM531epuYa6YA4074LI3SZHPSTi2AT+3yjzdupuiWs+OXP/yTtfB3c
        9FxCQyAI/ujtxcQs+dWIEndzblr80rUlg+pufSg=
X-Google-Smtp-Source: ABdhPJzt47dBa+fSAPPN8cnod1SejW6ShTFB2A7mEWGGh8qYPTNUySe1N4iP2PUtwlVTAaw2Heqf7Vr5tIti8Q3n5EU=
X-Received: by 2002:a67:6684:: with SMTP id a126mr21341554vsc.87.1641552304362;
 Fri, 07 Jan 2022 02:45:04 -0800 (PST)
MIME-Version: 1.0
Reply-To: drdavidgilbert2@gmail.com
Sender: mradamsphillips6@gmail.com
Received: by 2002:a59:b2cf:0:b0:27a:3b42:f3ce with HTTP; Fri, 7 Jan 2022
 02:45:03 -0800 (PST)
From:   Dr David Gilbert <drdavidgilberts2@gmail.com>
Date:   Fri, 7 Jan 2022 02:45:03 -0800
X-Google-Sender-Auth: 335GKRu-ldHB371wco-Wy91H_y4
Message-ID: <CAJJi7pNVG10KUzVZC-BkT-h8+w2tHf4d0NPMg3XryKVV4xrX4g@mail.gmail.com>
Subject: Its an urgent!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

I am Dr. David Gilbert, the director of the accounts & auditing
department at the ONLINE Banking Central Bank Of Burkina Faso
Ouagadougou-west Africa, (CBB) With due respect, I have decided to
contact you on a business transaction, I will like you to help me in
receiving of this fund into your Bank Account through online banking,
However; It's just my urgent need for foreign partner that made me to
contact you for this transaction, In my department I discovered an
abandoned sum of (US$10.5 Million dollars) in an account that belongs
to one of our foreign Customer (MR. PAUL LOUIS from Paris, France )
who died along time in 6th of December 2016 in car accident.

I am afraid if this money stays in our bank without claim for long
period of time, our government will step in because the Banking laws
here does not allow such huge amount of money to stay dormant for more
than (Seven) 7years, And you will receiving this money into your Bank
account within 10 or 14 banking days.

The Banking law and guideline here stipulates that if such money
remained unclaimed after 6 or 7years and above, the money will be
transferred into the Bank treasury as unclaimed fund, I agree that 40%
of this money will be for you as foreign partner in respect to the
provision of a foreign account, and while 50%would be for me, then 10%
will map out for the expenses.

If you agree to my business proposal, further details of the transfer
will be forwarded to you as soon as I receive your return mail, Make
sure you keep this transaction as your top secret and make it
confidential till we receive the fund into your bank account that you
will provide to the Bank, Don't disclose it to anybody, because the
secrecy of this transaction is as well as the success of it.

I quickly inform you because the new system of payment policy has been
adopted and it will be very easy and short listed for payment via
Online Banking, So immediately I receive your update; I will direct
you on how to contact ONLINE Central Banking through their E-mail
address, where the funds will be approved by Central Bank of Burkina
Faso and transfer into your bank account through online Banking and
make assure you follow their online payment instruction to enable the
transaction goes successful.

Yours Sincerely,
Dr. David Gilbert.
Central Bank.
