Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C33159BC35
	for <lists+linux-scsi@lfdr.de>; Mon, 22 Aug 2022 11:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiHVJCj (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 22 Aug 2022 05:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233967AbiHVJC3 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 22 Aug 2022 05:02:29 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6332F008
        for <linux-scsi@vger.kernel.org>; Mon, 22 Aug 2022 02:02:28 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id g8so5443886plq.11
        for <linux-scsi@vger.kernel.org>; Mon, 22 Aug 2022 02:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=p9eXFPYaWoUQYd93GZHfKWGzwlV1gqge90LRrpP+sWM=;
        b=Gn33yOewWkI5C9V6G7ukU0PQo3eyHKxFNaomLXhM1GgS2Wik2x8kBs7GiCNhYnuVMJ
         l5zgxJUfXzHl9kdXNmbpWSeDvrFpCVDvg3COScbm8Fqb3KS6t8mbt83izyKXXMMW3DbM
         gcEcFFvc2957bcjT8HwZ4xA9QzEfXhEPE6YB5oYIAsfjBcBd6RhkZS5p04Vi3QJxKLPE
         9X7GWbLHAK5lbFcDiuw7Hj9py4n+lQyQ+7FA4VxApQfZFKjxFR46pJUH/1Atb+d3jJ9B
         Ww67XDXVBn2b6XUGUf7Ni7BEkuRUGjk+drOz0OCDuwpc87D0WK2cswe97CQjqyMgU0ZE
         I4Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=p9eXFPYaWoUQYd93GZHfKWGzwlV1gqge90LRrpP+sWM=;
        b=ck2y2ZNBrzKGvZG47lrhqVQSAqB/SRDNzNuCn1QdB5n/gv40G09gLJfQxGSN53vJ6e
         VM36iuijRURWMLaf0df8Xw6mioiZ8QTHiZUNPqannkqtWb2n41ZdLcp4hUXV/bokHUm3
         rxhmzcs7Z9P2iYu1iN/8i/A4unGawMIlMfrWTI6XpGP9/cwMkodDjSg71M4Mua2kfnCR
         IqP7DzW5mFHmvJUoi6PFz4Y7tur4ZSTTu0P+Qbc9LpTGzvEcR1TUC+0vDDcL6O2ZBQ9J
         5JO6yUWyaWFWo8VYKTG6oGjyF7zvpoFCfcnlfehsKPDVfYikEgLPrqWYn6d8h0ASkEuV
         pzpg==
X-Gm-Message-State: ACgBeo3IZuP5e7DnckX0ooUGNUz3eNdbVii7EiyxRu1/LEdmyAUM0eko
        7e6cAAn4QikD0gqdm31yabk+ZAdUQvhM7FdQOkk=
X-Google-Smtp-Source: AA6agR7Nk4UytFrFc7xwvZvfm0WFV7sfC/UlPNmKrYzJxGY+sY1csrisCXE88VhWTiCn5Ja3nYvfCDaFoaWeaN2/J4k=
X-Received: by 2002:a17:90b:1c90:b0:1f8:42dd:9eba with SMTP id
 oo16-20020a17090b1c9000b001f842dd9ebamr28431087pjb.160.1661158947919; Mon, 22
 Aug 2022 02:02:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7022:4185:b0:43:a6bb:bfcd with HTTP; Mon, 22 Aug 2022
 02:02:27 -0700 (PDT)
Reply-To: lindacliford05@yahoo.com
From:   linsa cliford <linda27cliford@gmail.com>
Date:   Mon, 22 Aug 2022 06:02:27 -0300
Message-ID: <CAKYqKb6jwG8jHH-Asi6D2uVinUujTbRgymBFNRbO4rDEzXgh5g@mail.gmail.com>
Subject: WITH DUE RESPECT
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:634 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5728]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [linda27cliford[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [lindacliford05[at]yahoo.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

  Drear Love One,

  Good day dear love one my name is miss Lnda Cliford  from cote
d'ivoire please i need your help for fund transfer of 2,500 000 us
dollars  if you  are
willing please get back to me  for  more information thanks and have a
good day,
Waiting to hear from you thanks,

your s Linda Clifford
Regards
