Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB31D5259CE
	for <lists+linux-scsi@lfdr.de>; Fri, 13 May 2022 04:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376580AbiEMCyc (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 12 May 2022 22:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376571AbiEMCya (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 12 May 2022 22:54:30 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35D627EBBB
        for <linux-scsi@vger.kernel.org>; Thu, 12 May 2022 19:54:29 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id v59so13052794ybi.12
        for <linux-scsi@vger.kernel.org>; Thu, 12 May 2022 19:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=nnvpsXZDjD9PPijZhr63ZvFPBzBjg8TJW5OmOLJF1cg=;
        b=b4PzMs5ex97Xbo2g1AP5jnklK+P07SPLb/GWgp3X7PL0exmtRL+cIG+cOG5k3gIuVY
         gexpZSgBydOVASN49M/aj9H79/GScZTMgc0DGQxm9i+/R5catImxq15Kj1iQ59Mxhig6
         bYhU4O8KME2NbrqpdxA7HDBzX2X3ZHbslbOUi0x7j+g9t09HbL0kBdW4K4EMX8OCtUQ2
         0aNiym5eU004RblkGRBAfC40pRB7pVaYbCOkD58nRzkfx8jQzQQ47PQjU2gyAZffuVQ2
         I72/07fi7sDTOxp+cP0Xoc29DUC0ZafGUeDi4AYtGRMpWRBp9/UYkMre3FSLe6QUVesC
         7mLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=nnvpsXZDjD9PPijZhr63ZvFPBzBjg8TJW5OmOLJF1cg=;
        b=TKWz1vsKiuNnueACHqzcL6aSTUoZrXO5d/OtJVr6/ZnmywEeMiBum13aU8UDMctUsR
         BtuSppoaHzkbQBI0wK/pw6Ywolom8YLoY1S53Pqfv4XPTm8icX/ONUWLTJ/CuwtxsYdU
         FZzyBKviUy0w56JRwsB3hSSCR5Tjl4udPusntmsEtfR/XmG0deefGNa+f2VeQAT+oDAf
         MQtZFjdcZpMIEnadXrZs5w8EcI13tuYTKRtxiQLoVoTZjTAnNZEowrZ2sZxWvPDc4DIN
         Ul+1/+B34rp/dE5s3Rny19aufH1YhdFnG/D464se+2XYKJ/OQIw3Bmuk7A0cEehdaSaY
         7muQ==
X-Gm-Message-State: AOAM532/IpFsV1NJED5sFSyrtv5JBgOZXQi9jwfsbt8KOv87oXsTHsie
        zEBPzf3I/0f+MHRSyozWzqXh+wzW+Y3O8RTVv+M=
X-Google-Smtp-Source: ABdhPJwLJ5VsT4idi2f1coaNwhoJp5WhFOGnNWAt7e3GDLMlIAMkEcnelNojGC+fkGL92uRlODQwjPJth3UrQM+7zjs=
X-Received: by 2002:a25:8f82:0:b0:64b:4d9:46fe with SMTP id
 u2-20020a258f82000000b0064b04d946femr2742971ybl.479.1652410468842; Thu, 12
 May 2022 19:54:28 -0700 (PDT)
MIME-Version: 1.0
Sender: zanelegborlormenh@gmail.com
Received: by 2002:a05:7000:604b:0:0:0:0 with HTTP; Thu, 12 May 2022 19:54:27
 -0700 (PDT)
From:   UNDP <info.uniidp@gmail.com>
Date:   Fri, 13 May 2022 03:54:27 +0100
X-Google-Sender-Auth: 9ZD8n_vkNJssvldZydro1aJMH1Q
Message-ID: <CAP1L+kKWon2T0NmC_PF1wjWo++4XZxtRRHY-A7ot6C84PAx9oQ@mail.gmail.com>
Subject: Greetings
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        LOTS_OF_MONEY,MONEY_FRAUD_3,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Greetings!

We are writing this message to you from the United Nations Centre to
inform you that you have been chosen as our Representative in your
country, to distribute the total sum of $500,000 US Dollars,For
Palliative Care Empowerment in order to help the poor people in your
city. Such as the Disabled people, The homeless, Orphanages,
schools,and Generals=E2=80=99 Hospitals,if you receive the message reply to=
 us
with your details via this Email:( info.undep@consultant.com ) For
more information about the Palliative Care payment.

Best Regards.
Management
Wallace Harrison
Office E-mail:( info.undep@consultant.com )
Office Address: New York NY 10017 United States
